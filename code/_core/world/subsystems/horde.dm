#define HORDE_DELAY SECONDS_TO_DECISECONDS(120)
#define HORDE_DELAY_RECHECK SECONDS_TO_DECISECONDS(30)


SUBSYSTEM_DEF(horde)
	name = "Horde Subsystem"
	desc = "Spawns hoards for each player to fight."
	priority = SS_ORDER_LAST
	tick_rate = SECONDS_TO_TICKS(10)

	var/list/queued_players = list() //Assoc list.
	var/list/queued_overdue_players = list() //NOT AN ASSOC LIST

	//var/list/ckey_to_current_squads = list() //Assoc list

	var/list/ckey_to_time_to_horde = list() //Assoc list

	tick_usage_max = 25

	var/list/enemies_to_send_per_difficulty = list(
		DIFFICULTY_EASY = 1,
		DIFFICULTY_NORMAL = 2,
		DIFFICULTY_HARD = 3,
		DIFFICULTY_EXTREME = 4,
		DIFFICULTY_NIGHTMARE = 5
	)

	var/enable = FALSE

	var/list/all_horde_data_types = list()

/subsystem/horde/Initialize()

	for(var/k in subtypesof(/horde_data/))
		var/horde_data/HD = new k
		all_horde_data_types[k] = HD

	return TRUE

//The way that this works is that once every 10 seconds, it checks a single player to see if there are any valid spawns for it.
//It's better this way so that the system is staggered out and 30 players don't get processed on a single tick.
//There is a "failsafe" for when the player is overdue for an ass kinking.

/subsystem/horde/on_life()

	if(!enable)
		return TRUE

	for(var/k in all_players)
		var/mob/living/advanced/player/P = k
		CHECK_TICK_SAFE(tick_usage_max,FPS_SERVER)
		if(P.dead || !P.ckey || P.loyalty_tag != "NanoTrasen")
			continue
		var/area/A = get_area(P)
		if(A.area_identifier != "Mission")
			continue
		if(ckey_to_time_to_horde[P.ckey] && ckey_to_time_to_horde[P.ckey] > world.time)
			continue
		ckey_to_time_to_horde[P.ckey] = world.time + HORDE_DELAY
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
		CHECK_TICK_SAFE(tick_usage_max,FPS_SERVER)
		queued_overdue_players -= ckey
		var/client/C = CLIENT(ckey)
		if(!C || !is_player(C.mob)) //They are likely a ghost now.
			continue
		var/mob/living/advanced/player/P = C.mob
		if(P.loyalty_tag != "NanoTrasen" || P.dead)
			continue
		var/turf/T = get_turf(P)
		if(!T)
			continue
		if(SSdmm_suite.is_pvp_coord(T.x,T.y,T.z))
			continue
		var/area/A = T.loc
		if(A.area_identifier != "Mission")
			continue
		if(P.health && rand() < 1 - (P.health.health_current/P.health.health_max))
			ckey_to_time_to_horde[P.ckey] = world.time + HORDE_DELAY_RECHECK //Forgiveness.
			continue
		var/mob/living/squad_to_send = get_squad_to_send(P)
		if(!squad_to_send || !send_squad(P,squad_to_send))
			ckey_to_time_to_horde[P.ckey] = world.time + HORDE_DELAY_RECHECK
			continue
		log_subsystem(src.name,"Sending horde to [P.get_debug_name()]")

	return TRUE

/subsystem/horde/proc/get_squad_to_send(var/mob/living/advanced/player/victim)

	if(prob(20) && SStax.check_delinquent(victim))
		return /mob/living/advanced/npc/tax_collector

	var/area/A = get_area(victim)

	if(!A || !A.horde_data)
		return null

	var/horde_data/found_horde_data = src.all_horde_data_types[A.horde_data]

	var/chosen_key = pickweight(found_horde_data.horde_weights)

	if(istext(chosen_key))
		return found_horde_data.horde_squads[chosen_key]
	else
		return chosen_key

/subsystem/horde/proc/send_squad(var/mob/victim,var/mob/living/attacker_type,var/bypass_restrictions=FALSE,var/horde_count_override=0,var/debug=FALSE)

	var/turf/T = get_turf(victim)
	if(!T)
		return FALSE

	var/area/A = T.loc
	if(!bypass_restrictions && A.area_identifier != "Mission")
		if(debug) log_debug("Could not send squad: Area identifier was expected to be Mission, but it was [A.area_identifier].")
		return FALSE
	//Okay. Here is the fun part. Finding spawns.
	var/my_chunk_x = T.x/CHUNK_SIZE
	var/my_chunk_y = T.y/CHUNK_SIZE
	my_chunk_x = CEILING(my_chunk_x,1)
	my_chunk_y = CEILING(my_chunk_x,1)
	var/my_chunk_z = T.z

	var/chunk/victim_chunk = SSchunk.chunks[my_chunk_z][my_chunk_x][my_chunk_y]
	if(!length(victim_chunk.nodes))
		if(debug) log_debug("Could not send squad: Victim's chunk location had no valid nodes.")
		return FALSE

	if(debug) log_debug("Found victim chunk ([victim_chunk.x],[victim_chunk.y],[victim_chunk.z]).")

	var/obj/marker/map_node/N_end = find_closest_node(T)
	if(!N_end)
		if(debug) log_debug("Could not send squad: Could not find a closest node to the player..")
		return FALSE

	var/list/valid_nodes = list()

	for(var/x=-2,x<=2,x+=2) for(var/y=-2,y<=2,y+=2)
		if(x==0 && y==0)
			continue
		var/chunk_x = my_chunk_x + x
		var/chunk_y = my_chunk_y + y
		if(chunk_x <= 0 || chunk_x > world.maxx/CHUNK_SIZE)
			continue
		if(chunk_y <= 0 || chunk_y > world.maxy/CHUNK_SIZE)
			continue
		var/chunk/C = SSchunk.chunks[my_chunk_z][chunk_x][chunk_y]
		if(length(C.players))
			continue
		for(var/k in C.nodes)
			var/obj/marker/map_node/N = k
			if(!bypass_restrictions)
				var/turf/TN = N.loc
				var/area/AN = TN.loc
				if(AN.flags_area & FLAG_AREA_NO_HORDE)
					continue
			valid_nodes += N

	if(!length(valid_nodes))
		if(debug) log_debug("Could not send squad: Found zero valid nodes to place squad at.")
		return FALSE

	var/obj/marker/map_node/N_start = pick(valid_nodes)
	var/turf/squad_spawn = get_turf(N_start)

	if(debug)
		var/N_chunk_x = squad_spawn.x/CHUNK_SIZE
		N_chunk_x = FLOOR(N_chunk_x,1)
		var/N_chunk_y = squad_spawn.y/CHUNK_SIZE
		N_chunk_y = FLOOR(N_chunk_y,1)
		var/N_chunk_z = squad_spawn.z
		var/chunk/SC = SSchunk.chunks[N_chunk_z][N_chunk_x][N_chunk_y]
		log_debug("Found squad chunk ([SC.x],[SC.y],[SC.z]).")


	var/list/obj/marker/map_node/found_path = AStar_Circle_node(N_start,N_end,debug=TRUE)
	if(!found_path)
		if(debug) log_debug("Could not send squad: Could not find a path from [N_start.get_debug_name()] to [N_end.get_debug_name()].")
		return FALSE

	var/list/valid_directions = list(null,NORTH,EAST,SOUTH,WEST)


	var/enemies_to_send = horde_count_override
	if(!enemies_to_send && is_player(victim))
		var/mob/living/advanced/player/P = victim
		enemies_to_send = enemies_to_send_per_difficulty[P.get_difficulty()]

	if(!bypass_restrictions && victim.ckey_last)
		enemies_to_send -= length(ckeys_being_hunt_by[victim.ckey_last])

	if(enemies_to_send <= 0)
		if(debug) log_debug("Could not send squad: Target already has too many squads being sent after them.")
		return TRUE //Already being hunted.

	. = 0
	var/area/sent_area //debug only
	for(var/i=1,i<=min(enemies_to_send,4),i++) //Send at most only 4 at a time.
		var/turf/T2 = get_step(squad_spawn,valid_directions[1 + (i % 4)])
		if(!T) continue
		var/local_attacker_type = islist(attacker_type) ? pickweight(attacker_type) : attacker_type
		var/mob/living/Z = new local_attacker_type(T2)
		INITIALIZE(Z)
		GENERATE(Z)
		FINALIZE(Z)
		if(!Z.ai?.set_hunt_target(victim))
			qdel(Z)
			break
		else
			Z.ai.delete_on_no_path = TRUE
			if(debug)
				Z.ai.debug = TRUE
			. += 1
			if(debug && !sent_area)
				sent_area = get_area(Z)

	if(debug)
		if(. <= 0)
			log_debug("Could not send squad: AI could not properly set their hunt target.")
		else
			log_debug("Sent squad. [.] expected squad members spawned at [squad_spawn.get_debug_name()].")

