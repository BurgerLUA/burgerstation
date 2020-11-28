SUBSYSTEM_DEF(bosses)
	name = "Boss Subsystem"
	desc = "Tracks which players are bossfighting someone."
	tick_rate = SECONDS_TO_TICKS(4)
	priority = SS_ORDER_IMPORTANT
	var/list/tracked_bosses = list()
	var/list/living_bosses = list()

/subsystem/bosses/proc/check_boss(var/mob/living/L)

	if(L.dead || L.qdeleting)
		for(var/v in L.players_fighting_boss)
			var/mob/living/advanced/P = v
			CHECK_TICK(tick_usage_max,FPS_SERVER*5)
			L.remove_player_from_boss(P)
		return FALSE

	if(L.ai)
		var/ai/AI = L.ai
		if(AI.objective_attack)
			for(var/mob/living/advanced/P in view(L,L.boss_range))
				CHECK_TICK(tick_usage_max,FPS_SERVER*5)
				L.add_player_to_boss(P)

	for(var/v in L.players_fighting_boss)
		var/mob/living/advanced/P = v
		CHECK_TICK(tick_usage_max,FPS_SERVER*5)
		if(get_dist(P,L) >= L.boss_range*2)
			L.remove_player_from_boss(P)

	return TRUE

/subsystem/bosses/on_life()

	for(var/k in tracked_bosses)
		var/mob/living/L = k
		if(check_boss(L) == null)
			tracked_bosses -= L
			qdel(L)
			log_error("WARNING! Boss [L.get_debug_name()] didn't complete tracked_bosses() and thus was deleted.")

	return TRUE

/mob/living/proc/update_boss_health()
	for(var/k in players_fighting_boss)
		var/mob/living/advanced/P = k
		for(var/obj/hud/button/boss_health/B in P.buttons)
			B.target_bosses |= src
			B.update_stats()

/mob/living/proc/add_player_to_boss(var/mob/living/advanced/player/P)
	if(P in src.players_fighting_boss)
		return FALSE
	players_fighting_boss += P
	for(var/obj/hud/button/boss_health/B in P.buttons)
		B.target_bosses |= src
		B.update_stats()

/mob/living/proc/remove_player_from_boss(var/mob/living/advanced/player/P)
	if(!(P in src.players_fighting_boss))
		return FALSE
	players_fighting_boss -= P
	for(var/obj/hud/button/boss_health/B in P.buttons)
		B.target_bosses -= src
		B.update_stats()