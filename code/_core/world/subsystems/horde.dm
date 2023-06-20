#define HORDE_DELAY SECONDS_TO_DECISECONDS(120)
#define HORDE_DELAY_RECHECK SECONDS_TO_DECISECONDS(30)
#define HORDE_DELAY_DRILL SECONDS_TO_DECISECONDS(45)


SUBSYSTEM_DEF(horde)
	name = "Horde Subsystem"
	desc = "Spawns hoards for each player to fight."
	priority = SS_ORDER_LAST
	tick_rate = SECONDS_TO_TICKS(10)

	var/list/queued_players = list() //Assoc list.
	var/list/queued_overdue_players = list() //Assoc list.

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
	var/list/all_drills = list() //list of all drills to send hordes to. Assoc.


/subsystem/horde/unclog(var/mob/caller)
	enable = FALSE
	. = ..()

/subsystem/horde/Initialize()

	for(var/k in subtypesof(/horde_data/))
		var/horde_data/HD = new k
		all_horde_data_types[k] = HD

	return TRUE

//The way that this works is that once every 10 seconds, it checks a single player to see if there are any valid spawns for it.
//It's better this way so that the system is staggered out and 30 players don't get processed on a single tick.
//There is a "failsafe" for when the player is overdue for an ass kicking.

/subsystem/horde/on_life()

	if(!enable)
		return TRUE

	for(var/k in all_players)
		var/mob/living/advanced/player/P = k
		CHECK_TICK(tick_usage_max,FPS_SERVER)
		if(P.dead || !P.ckey || P.loyalty_tag != "NanoTrasen")
			continue
		var/area/A = get_area(P)
		if(A.area_identifier != "Mission")
			continue
		if(ckey_to_time_to_horde[P.ckey] && ckey_to_time_to_horde[P.ckey] > world.time)
			continue
		ckey_to_time_to_horde[P.ckey] = world.time + HORDE_DELAY
		if(queued_players[P.ckey]) //Overdue
			queued_players -= P.ckey //Don't count twice!
			queued_overdue_players[P.ckey] = TRUE
		else
			queued_players[P.ckey] = TRUE

	if(length(queued_players))
		//It treats the first entry of found players who need an ass kicking as overdue so it sends mobs.
		//Lazy and a bit of a misnomer, but it saves code.
		queued_overdue_players += queued_players[1]
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
		var/turf/T = get_turf(P)
		if(!T)
			continue
		if(SSdmm_suite.is_pvp_coord(T.x,T.y,T.z))
			continue
		var/area/A = T.loc
		if(A.area_identifier != "Mission" || A.flags_area & FLAG_AREA_NO_HORDE)
			continue
		if(P.health && rand() > P.health.health_current/P.health.health_max)
			ckey_to_time_to_horde[P.ckey] = world.time + HORDE_DELAY_RECHECK //Forgiveness.
			continue
		var/mob/living/squad_to_send = get_squad_to_send(P)
		if(!squad_to_send || !send_squad(P,squad_to_send))
			ckey_to_time_to_horde[P.ckey] = world.time + HORDE_DELAY_RECHECK
			continue
		log_subsystem(src.name,"Sending horde to [P.get_debug_name()]")

	for(var/drill in all_drills)
		CHECK_TICK(tick_usage_max,FPS_SERVER)
		var/obj/structure/interactive/mining_drill/D = drill
		if(all_drills[D] && all_drills[D] > world.time)
			continue
		if(!D || D.qdeleting) //Drill destroyed, mission accomplished.
			continue
		if(!IS_THINKING(D)) // Drill isnt on. No noise, no horde.
			continue
		var/turf/T = get_turf(D)
		if(!T)
			continue
		var/area/A = T.loc
		if(A.area_identifier != "Mission") //I dont know why theres a drill not on mission but sanity
			continue
		var/mob/living/squad_to_send = get_squad_to_send(D)
		if(!squad_to_send || !send_squad(D,squad_to_send,TRUE))//THERE IS NO SAFE ORE MINING.
			all_drills[D] = world.time + HORDE_DELAY_RECHECK
			continue
		all_drills[D] = world.time + HORDE_DELAY_DRILL

	return TRUE

/subsystem/horde/proc/get_squad_to_send(var/atom/target)

	//Get the hoard to send.
	var/area/A = get_area(target)

	if(!A || !A.horde_data)
		return null

	var/horde_data/found_horde_data = src.all_horde_data_types[A.horde_data]

	if(!found_horde_data || !found_horde_data.ignore_gamemode)
		if(prob(40) && is_player(target) && SStax.check_delinquent(target))
			found_horde_data = src.all_horde_data_types[/horde_data/tax]
		else if(A.horde_data == "mission" && SSgamemode && SSgamemode.active_gamemode && SSgamemode.active_gamemode.gamemode_horde_data)
			found_horde_data = src.all_horde_data_types[SSgamemode.active_gamemode.gamemode_horde_data]

	if(!found_horde_data)
		return null

	var/chosen_key = pickweight(found_horde_data.horde_weights)

	if(istext(chosen_key))
		return found_horde_data.horde_squads[chosen_key]
	else
		return chosen_key

/subsystem/horde/proc/send_squad(var/atom/target,var/mob/living/attacker_type,var/bypass_restrictions=FALSE,var/horde_count_override=0,var/debug=FALSE)

	var/enemies_to_send = horde_count_override
	if(!enemies_to_send && is_player(target))
		var/mob/living/advanced/player/P = target
		enemies_to_send = enemies_to_send_per_difficulty[P.get_difficulty()]
		if(!bypass_restrictions && P.ckey_last)
			enemies_to_send -= length(ckeys_being_hunt_by[P.ckey_last])

	if(enemies_to_send <= 0)
		if(debug) log_debug("Could not send squad: Target already has too many squads being sent after them.")
		return TRUE //Already being hunted.

	//Setting up turf and area.
	var/turf/T = get_turf(target)
	if(!T)
		if(debug) log_debug("Could not send squad: No valid turf detected!")
		return FALSE
	var/area/A = T.loc

	//Safety Check.
	if(!bypass_restrictions && A.area_identifier != "Mission")
		if(debug) log_debug("Could not send squad: Not on mission map!")
		return FALSE

	if(!bypass_restrictions && A.flags_area & FLAG_AREA_NO_HORDE)
		if(debug) log_debug("Could not send squad: Area forbids hordes!")
		return FALSE

	var/chunk/C = CHUNK(T)
	if(!C)
		if(debug) log_debug("Could not send squad: Could not find a valid chunk.")
		return FALSE

	var/obj/marker/map_node/N_end = find_closest_node(T,VIEW_RANGE*2)
	if(!N_end)
		if(debug) log_debug("Could not send squad: Could not find a closest valid node to the target.")
		return FALSE

	var/list/valid_nodes = list()
	var/list/chunks_checked = list(C = TRUE)
	for(var/k in C.adjacent_chunks)
		var/chunk/AC = k
		chunks_checked[AC] = TRUE
		if(length(AC.players))
			continue
		for(var/j in AC.adjacent_chunks)
			var/chunk/ACC = j
			if(chunks_checked[ACC])
				continue
			chunks_checked[ACC] = TRUE
			if(length(ACC.players))
				continue
			for(var/h in ACC.nodes)
				var/obj/marker/map_node/N = h
				var/turf/TN = N.loc
				if(!TN || !is_simulated(TN))
					continue
				var/area/AN = TN.loc
				if(!AN || AN.flags_area & FLAG_AREA_NO_HORDE)
					continue
				if(length(N.adjacent_map_nodes) != 1) //Find ending nodes only.
					continue
				valid_nodes += N

	if(!length(valid_nodes))
		if(debug) log_debug("Could not send squad: Could not find any valid nodes.")
		return FALSE

	var/list/obj/marker/map_node/found_path
	var/turf/squad_spawn
	for(var/i=1,i<=5,i++) //5 attempts.
		var/obj/marker/map_node/N_start = pick(valid_nodes)
		valid_nodes -= N_start
		found_path = AStar_Circle_node(N_start,N_end,debug=debug)
		if(found_path)
			squad_spawn = get_turf(N_start)
			break

	if(!found_path)
		if(debug) log_debug("Could not send squad: Could not find a valid path after 5 tries.")
		return FALSE

	var/list/valid_directions = list(null,NORTH,EAST,SOUTH,WEST)

	. = 0
	for(var/i=1,i<=min(enemies_to_send,4),i++) //Send at most only 4 at a time.
		var/turf/squad_spawn_offset = get_step(squad_spawn,valid_directions[1 + (i % 4)])
		if(!squad_spawn_offset || squad_spawn_offset.has_dense_atom)
			squad_spawn_offset = squad_spawn
		var/mob/living/Z = islist(attacker_type) ? pickweight(attacker_type) : attacker_type
		Z = new Z(squad_spawn_offset)
		INITIALIZE(Z)
		GENERATE(Z)
		FINALIZE(Z)
		if(!Z.ai)
			log_error("Warning: Tried making [Z.get_debug_name()] hunt, but it had no AI!")
			qdel(Z)
			break
		if(debug) Z.ai.debug = TRUE
		if(!Z.ai.set_path_node(found_path))
			log_error("Warning: Tried making [Z.get_debug_name()] hunt, but it couldn't path to the hunt target!")
			qdel(Z)
			break
		if(!Z.ai.set_hunt_target(target))
			log_error("Warning: Tried making [Z.get_debug_name()] hunt, but it couldn't set the hunt target ([target.get_debug_name()])!")
			qdel(Z)
			break
		Z.ai.delete_on_no_path = TRUE
		. += 1

	if(debug && . > 0)
		log_debug("Sent squad. [.] expected squad members spawned at [squad_spawn.get_debug_name()] in [squad_spawn.loc.get_debug_name()].")