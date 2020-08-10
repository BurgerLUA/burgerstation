/proc/within_range(var/atom/point_A,var/atom/point_B,var/range=VIEW_RANGE)

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

	var/list/list_of_ais = list()
	list_of_ais.Add(SSbossai.inactive_ai,SSbossai.active_ai,SSai.active_ai,SSai.inactive_ai)

	for(var/k in list_of_ais)
		CHECK_TICK(75,FPS_SERVER)
		var/ai/AI = k
		if(AI.owner.dead || AI.objective_attack)
			continue
		if(!within_range(AI.owner,epicenter,range))
			continue
		if(alert_source && !AI.is_enemy(alert_source))
			continue
		CALLBACK("alert_level_change_\ref[AI]",CEILING(AI.reaction_time*0.1,1),AI,/ai/proc/set_alert_level,alert_level,FALSE,epicenter)

	return TRUE

/proc/get_ais_in_range(var/range=VIEW_RANGE,var/atom/epicenter=usr)

	var/list/list_of_ais = list()
	list_of_ais.Add(SSbossai.inactive_ai,SSbossai.active_ai,SSai.active_ai,SSai.inactive_ai)

	for(var/k in list_of_ais)
		var/ai/AI = k
		var/mob/M = AI.owner
		if(get_dist(M,epicenter) > range)
			continue
		. += AI

	return .

