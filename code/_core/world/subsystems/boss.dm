SUBSYSTEM_DEF(bosses)
	name = "Boss Subsystem"
	desc = "Tracks which players are bossfighting someone."
	tick_rate = SECONDS_TO_TICKS(4)
	priority = SS_ORDER_FIRST
	var/list/tracked_bosses = list()
	var/list/living_bosses = list()

	var/list/tracked_rogue_crewmembers = list()

/subsystem/bosses/unclog(var/mob/caller)

	. = ..()

	for(var/k in tracked_bosses)
		var/mob/living/L = k
		tracked_bosses -= k
		if(!L || L.qdeleting)
			continue
		L.gib()


/subsystem/bosses/proc/check_boss(var/mob/living/L)

	if(L.dead || L.qdeleting) //Boss is dead or deleted.
		for(var/k in L.players_fighting_boss)
			var/mob/living/advanced/P = k
			L.remove_player_from_boss(P)
			CHECK_TICK(tick_usage_max,FPS_SERVER*5)
		return FALSE

	var/turf/boss_turf = get_turf(L)
	for(var/v in L.players_fighting_boss)
		var/mob/living/advanced/player/P = v
		var/turf/player_turf = get_turf(P)
		if(!boss_turf || !player_turf || player_turf.z != boss_turf.z)
			L.remove_player_from_boss(P)
			continue
		if(get_dist(player_turf,boss_turf) >= L.boss_range*2)
			if(L.ai)
				var/ai/AI = L.ai
				if(AI.objective_attack)
					var/turf/T = get_turf(AI.objective_attack)
					if(T && T.z == P.z && get_dist(T,P) <= L.boss_range*2)
						continue
			L.remove_player_from_boss(P)
		CHECK_TICK(tick_usage_max,FPS_SERVER*5)

	if(L.ai)
		var/ai/AI = L.ai
		if(AI.objective_attack) //Boss is officially in combat.
			for(var/mob/living/advanced/player/P in viewers(L.boss_range,L))
				if(L.loyalty_tag == P.loyalty_tag)
					continue
				L.add_player_to_boss(P)
				CHECK_TICK(tick_usage_max,FPS_SERVER*5)

	return TRUE

/subsystem/bosses/on_life()

	for(var/k in tracked_bosses)
		var/mob/living/L = k
		if(!L) // Invalid entry, for some reason.
			tracked_bosses -= k
			continue
		if(!check_boss(L))
			tracked_bosses -= L
			qdel(L)
			log_error("WARNING! Boss [L.get_debug_name()] didn't complete tracked_bosses() and thus was deleted.")
		CHECK_TICK(tick_usage_max,FPS_SERVER)

	return TRUE

/mob/living/proc/update_boss_health()
	for(var/k in players_fighting_boss)
		var/mob/living/advanced/P = k
		for(var/obj/hud/button/boss_health/B in P.buttons)
			B.target_bosses |= src
			B.update_stats()

/mob/living/proc/add_player_to_boss(var/mob/living/advanced/player/P)
	if(!P || P.qdeleting) //Can't add an invalid player.
		return FALSE
	players_fighting_boss |= P
	for(var/obj/hud/button/boss_health/B in P.buttons)
		B.target_bosses |= src
		B.update_stats()
	return TRUE

/mob/living/proc/remove_player_from_boss(var/mob/living/advanced/player/P)
	players_fighting_boss -= P
	if(!P || P.qdeleting)
		return TRUE
	for(var/obj/hud/button/boss_health/B in P.buttons)
		B.target_bosses -= src
		B.update_stats()
	return TRUE