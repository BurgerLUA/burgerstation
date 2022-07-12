SUBSYSTEM_DEF(horde)
	name = "Horde Subsystem"
	desc = "Spawns hoards for each player to fight."
	priority = SS_ORDER_LAST
	tick_rate = SECONDS_TO_TICKS(30)

	var/list/queued_players = list() //Assoc list.
	var/list/queued_overdue_players = list() //NOT AN ASSOC LIST

	var/list/ckey_to_current_squads = list() //Assoc list

	var/list/ckey_to_time_to_horde = list() //Assoc list

	tick_usage_max = 25
	cpu_usage_max = 25

	var/list/enemies_to_send_per_difficulty = list(
		DIFFICULTY_EASY = 3,
		DIFFICULTY_NORMAL = 4,
		DIFFICULTY_HARD = 5,
		DIFFICULTY_EXTREME = 8,
		DIFFICULTY_NIGHTMARE = 10
	)

	var/enable = FALSE


//The way that this works is that once every 10 seconds, it checks a single player to see if there are any valid spawns for it.
//It's better this way so that the system is staggered out and 30 players don't get processed on a single tick.
//There is a "failsafe" for when the player is overdue for an ass kinking.

/subsystem/horde/on_life()

	if(!enable)
		return TRUE

	for(var/k in all_players)
		var/mob/living/advanced/player/P = k
		if(P.dead || !P.ckey || P.loyalty_tag != "NanoTrasen")
			continue
		var/area/A = get_area(P)
		if(A.area_identifier != "Mission")
			continue
		if(ckey_to_time_to_horde[P.ckey] && ckey_to_time_to_horde[P.ckey] > world.time)
			continue
		ckey_to_time_to_horde[P.ckey] = world.time + SECONDS_TO_DECISECONDS(300)
		if(queued_players[P.ckey]) //Overdue
			queued_overdue_players |= P.ckey
		else
			queued_players[P.ckey] = TRUE

	if(length(queued_players))
		//It treats the first entry of found players who need an ass kicking as overdue so it sends mobs.
		//Lazy and a bit of a misnomer, but it saves code.
		queued_overdue_players |= queued_players[1]
		queued_players -= queued_players[1]

	for(var/ckey in queued_overdue_players)
		CHECK_TICK(tick_usage_max,FPS_SERVER)
		queued_overdue_players -= ckey
		var/client/C = CLIENT(ckey)
		if(!C || !is_player(C.mob)) //They are likely a ghost now.
			continue
		var/mob/living/advanced/player/P = C.mob
		if(P.loyalty_tag != "NanoTrasen" || P.dead)
			continue
		var/area/A = get_area(P)
		if(A.area_identifier != "Mission")
			continue

		var/list/mob/living/squads_to_send = get_squads_to_send(P)
		if(!squads_to_send)
			ckey_to_time_to_horde[P.ckey] = world.time + SECONDS_TO_DECISECONDS(60)
			continue
		var/mob/living/squad_to_send = pickweight(squads_to_send)
		if(!squad_to_send || !send_squad(P,squad_to_send))
			ckey_to_time_to_horde[P.ckey] = world.time + SECONDS_TO_DECISECONDS(60)
			continue
		log_subsystem(src.name,"Sending horde to [P.get_debug_name()]")

	return TRUE

/subsystem/horde/proc/get_squads_to_send(var/mob/living/advanced/player/victim)

	. = list()

	if(SStax.check_delinquent(victim))
		.[/mob/living/advanced/npc/tax_collector] = 100

	.[/mob/living/advanced/npc/zombie/civilian] = 100
	.[/mob/living/advanced/npc/syndicate] = 20
	.[/mob/living/advanced/npc/abductor] = 10
	.[/mob/living/advanced/npc/beefman] = 10
	.[/mob/living/advanced/npc/rev] = 10
	.[/mob/living/advanced/npc/space_soldier] = 5

	return .



/subsystem/horde/proc/send_squad(var/mob/victim,var/mob/living/attacker_type,var/bypass_restrictions=FALSE,var/debug=FALSE)

	var/turf/T = get_turf(victim)
	if(!T)
		return FALSE

	var/area/A = T.loc
	if(!bypass_restrictions && A.area_identifier != "Mission")
		if(debug) log_debug("Could not send squad: Area identifier was expected to be Mission, but it was [A.area_identifier].")
		return FALSE
	//Okay. Here is the fun part. Finding spawns.
	var/my_chunk_x = CEILING(victim.loc.x/CHUNK_SIZE,1)
	var/my_chunk_y = CEILING(victim.loc.y/CHUNK_SIZE,1)
	var/my_chunk_z = victim.loc.z

	var/list/valid_nodes = list()

	for(var/x=-1,x<=1,x++)
		var/real_x = my_chunk_x+x*2
		if(real_x <= 1 || real_x >= SSchunk.chunk_count_x-1)
			continue
		for(var/y=-1,y<=1,y++)
			if(x == 0 && y == 0) //Redundant checking.
				continue
			var/real_y = my_chunk_y+y*2
			if(real_y <= 1 || real_y >= SSchunk.chunk_count_y-1)
				continue

			var/chunk/CH_CENTER = SSchunk.chunks[my_chunk_z][real_x][real_y]
			if(length(CH_CENTER.players))
				continue
			var/valid=TRUE
			for(var/dir in DIRECTIONS_ALL)
				var/list/offsets = direction_to_pixel_offset(dir)
				var/check_x = real_x+offsets[1]
				var/check_y = real_y+offsets[2]
				if(check_x < 1 || check_x > SSchunk.chunk_count_x) //Corner.
					continue
				if(check_y < 1 || check_y > SSchunk.chunk_count_y) //Corner.
					continue
				var/chunk/CH = SSchunk.chunks[my_chunk_z][check_x][check_y]
				if(length(CH.players))
					valid = FALSE
					break
			if(!valid)
				continue
			valid_nodes |= CH_CENTER.nodes

	if(!length(valid_nodes))
		if(debug) log_debug("Could not send squad: Found zero valid nodes to place squad at.")
		return FALSE

	var/obj/marker/map_node/N_start = pick(valid_nodes)
	var/turf/squad_spawn = N_start.loc
	var/obj/marker/map_node/N_end = find_closest_node(T)
	if(!N_end)
		return FALSE
	var/list/obj/marker/map_node/found_path = N_start.find_path(N_end)
	if(!found_path)
		if(debug) log_debug("Could not send squad: Could not find a path from the squad selection point to the target.")
		return FALSE

	var/list/valid_directions = list(null,NORTH,EAST,SOUTH,WEST)


	var/enemies_to_send = 4
	if(is_player(victim))
		var/mob/living/advanced/player/P = victim
		enemies_to_send = enemies_to_send_per_difficulty[P.get_difficulty()]

	if(!bypass_restrictions && victim.ckey_last)
		enemies_to_send -= length(ckeys_being_hunt_by[victim.ckey_last])

	if(enemies_to_send <= 0)
		if(debug) log_debug("Could not send squad: Target already has too many squads being sent after them.")
		return TRUE //Already being hunted.

	. = 0
	var/area/sent_area
	for(var/i=1,i<=enemies_to_send,i++)
		var/turf/T2 = get_step(squad_spawn,valid_directions[1 + (i % 4)])
		if(!T) continue
		var/mob/living/Z = new attacker_type(T2)
		INITIALIZE(Z)
		GENERATE(Z)
		FINALIZE(Z)
		if(!Z.ai?.set_hunt_target(victim))
			qdel(Z)
		else
			. += 1
			if(debug && !sent_area)
				sent_area = get_area(Z)

	if(debug)
		if(. <= 0)
			log_debug("Could not send squad: AI could not properly set their hunt target.")
		else
			log_debug("Sent squad. [.] expected squad members spawned at [sent_area.get_debug_name()].")

