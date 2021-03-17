/ai/boss/

	objective_delay = DECISECONDS_TO_TICKS(10)

	true_sight = TRUE
	roaming_distance = 3

	use_alerts = TRUE

	use_cone_vision = FALSE

	radius_find_enemy = BOSS_RANGE
	radius_find_enemy_noise = BOSS_RANGE
	radius_find_enemy_caution = BOSS_RANGE
	radius_find_enemy_combat = BOSS_RANGE

	ignore_hazard_turfs = TRUE

	boss = TRUE

/*
/ai/boss/set_active(var/desired_active=TRUE,var/force=FALSE)

	if(!force && active == desired_active)
		return FALSE

	active = desired_active

	var/turf/T = get_turf(owner)
	var/z = "[T.z]"

	if(active)
		if(!SSbossai.active_ai_by_z[z])
			SSbossai.active_ai_by_z[z] = list()
		SSbossai.active_ai_by_z[z] |= src
		if(SSbossai.inactive_ai_by_z[z]) SSbossai.inactive_ai_by_z[z] -= src
		HOOK_ADD("post_move","\ref[src]_post_move",owner,src,.proc/post_move)
		HOOK_ADD("post_death","\ref[src]_post_death",owner,src,.proc/post_death)
	else
		if(!SSbossai.inactive_ai_by_z[z])
			SSbossai.inactive_ai_by_z[z] = list()
		if(SSbossai.active_ai_by_z[z]) SSbossai.active_ai_by_z[z] -= src
		SSbossai.inactive_ai_by_z[z] |= src
		set_alert_level(ALERT_LEVEL_NONE,TRUE)
		set_objective(null)
		set_move_objective(null)
		CALLBACK_REMOVE("set_new_objective_\ref[src]")
		attackers.Cut()
		obstacles.Cut()
		HOOK_REMOVE("post_move","\ref[src]_post_move",owner)
		HOOK_REMOVE("post_death","\ref[src]_post_death",owner)

	return TRUE
*/