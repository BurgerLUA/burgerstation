var/global/list/tracked_bosses = list()

/*
/proc/update_boss(var/boss_id)

	var/mob/living/L = tracked_bosses[boss_id]

	for(var/mob/living/advanced/player/P in view(L))
		for(var/obj/button/boss_health/B in P.buttons)
			B.target_boss = L
			B.update_stats()
*/