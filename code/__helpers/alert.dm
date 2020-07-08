/proc/within_range(var/atom/point_A,var/atom/point_B,var/range=VIEW_RANGE)

	point_A = get_turf(point_A)
	point_B = get_turf(point_B)

	if(!point_A || !point_B)
		return FALSE

	if(point_A.z != point_B.z)
		return FALSE

	return get_dist(point_A,point_B) <= VIEW_RANGE


/proc/create_alert(var/range = VIEW_RANGE,var/atom/epicenter=usr,var/atom/alert_source = usr,var/alert_level = ALERT_LEVEL_NOISE)

	if(!alert_source)
		CRASH_SAFE("create_alert() had no alert_source!")
		return FALSE

	if(!epicenter)
		CRASH_SAFE("create_alert() had no epicenter!")
		return FALSE

	var/list/list_of_ais = all_boss_ai + all_living_ai

	for(var/ai/AI in list_of_ais)
		CHECK_TICK
		if(AI.alert_level == ALERT_LEVEL_COMBAT)
			continue
		var/mob/M = AI.owner
		if(!within_range(M,epicenter,range))
			continue
		if(!AI.is_enemy(alert_source))
			continue
		CALLBACK("alert_level_change_\ref[M]",CEILING(AI.reaction_time*0.1,1),AI,/ai/proc/set_alert_level,alert_level,FALSE,epicenter)

	return TRUE

/proc/get_ais_in_range(var/range=VIEW_RANGE,var/atom/epicenter=usr)

	var/list/list_of_ais = all_boss_ai + all_living_ai

	for(var/ai/AI in list_of_ais)
		var/mob/M = AI.owner
		if(get_dist(M,epicenter) > range)
			continue
		. += AI

	return .

