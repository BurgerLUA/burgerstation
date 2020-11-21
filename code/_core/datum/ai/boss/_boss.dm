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

/ai/boss/set_active(var/desired_active=TRUE,var/force=FALSE)

	if(!force && active == desired_active)
		return FALSE

	active = desired_active

	if(active)
		SSbossai.active_ai |= src
		SSbossai.inactive_ai -= src
	else
		SSbossai.active_ai -= src
		SSbossai.inactive_ai |= src

	return TRUE