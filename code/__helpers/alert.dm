/*
/proc/within_range(var/atom/point_A,var/atom/point_B,var/range=VIEW_RANGE)

	if(!point_A || !point_B)
		return FALSE

	if(!isturf(point_A))
		point_A = get_turf(point_A)

	if(!isturf(point_B))
		point_B = get_turf(point_B)

	if(point_A.z != point_B.z)
		return FALSE

	return (abs(point_A.x - point_B.x) + abs(point_A.y - point_B.y)) <= range
*/


#define within_range(point_A,point_B,range) (get_dist(point_A,point_B) <= range)

/proc/create_alert_process(var/list/list_to_use,var/range = VIEW_RANGE,var/atom/epicenter=usr,var/atom/alert_source,var/alert_level = ALERT_LEVEL_NOISE,var/visual=FALSE)
	for(var/k in list_to_use)
		CHECK_TICK(75,FPS_SERVER*4)
		var/ai/AI = k
		if(!AI || AI.owner || AI.owner.dead || AI.objective_attack)
			continue
		if(!within_range(AI.owner,epicenter,VIEW_RANGE))
			continue
		if(visual && !AI.owner.is_facing(epicenter))
			continue
		if(alert_source && !AI.is_enemy(alert_source))
			continue
		CALLBACK("alert_level_change_\ref[AI]",CEILING(AI.reaction_time*0.1,1),AI,/ai/proc/set_alert_level,alert_level,FALSE,epicenter,alert_source)

/proc/create_alert(var/range = VIEW_RANGE,var/atom/epicenter=usr,var/atom/alert_source,var/alert_level = ALERT_LEVEL_NOISE,var/visual=FALSE)

	if(!epicenter)
		CRASH_SAFE("create_alert() had no epicenter!")
		return FALSE

	create_alert_process(SSbossai.inactive_ai,range,epicenter,alert_source,alert_level,visual)
	create_alert_process(SSbossai.active_ai,range,epicenter,alert_source,alert_level,visual)
	create_alert_process(SSai.inactive_ai,range,epicenter,alert_source,alert_level,visual)
	create_alert_process(SSai.active_ai,range,epicenter,alert_source,alert_level,visual)

	return TRUE

/*
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
*/

