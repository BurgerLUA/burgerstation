/ai/turret
	radius_find_enemy = VIEW_RANGE
	radius_find_enemy_noise = VIEW_RANGE
	radius_find_enemy_caution = VIEW_RANGE + ZOOM_RANGE
	radius_find_enemy_combat = VIEW_RANGE + ZOOM_RANGE

	distance_target_max = INFINITY

	roaming_distance = 0

	use_cone_vision = TRUE

	aggression = 2
	assistance = 0


	var/should_scan = TRUE
	var/scan_at_alert_level = ALERT_LEVEL_NONE
	var/list/valid_scan_dirs
	var/last_scan = 0
	var/scan_key = 1
	var/scan_mod = 1


/ai/turret/New(var/mob/living/desired_owner)

	. = ..()

	var/initial_dir = initial(owner.dir)

	valid_scan_dirs = list()
	valid_scan_dirs += turn(initial_dir,90)
	valid_scan_dirs += turn(initial_dir,45)
	valid_scan_dirs += initial_dir
	valid_scan_dirs += turn(initial_dir,-45)
	valid_scan_dirs += turn(initial_dir,-90)

	return .

/ai/turret/on_life()

	. = ..()

	if(. && should_scan && alert_level != ALERT_LEVEL_COMBAT && alert_level >= scan_at_alert_level && length(valid_scan_dirs))
		var/scan_delay = 10
		switch(alert_level)
			if(ALERT_LEVEL_NONE)
				scan_delay = 15
			if(ALERT_LEVEL_NOISE)
				scan_delay = 10
			if(ALERT_LEVEL_CAUTION)
				scan_delay = 5

		if(world.time - last_scan >= scan_delay)
			var/scan_dir_length = length(valid_scan_dirs)
			scan_key += scan_mod
			if(scan_key == scan_dir_length)
				scan_mod = -1
			else if(scan_key == 1)
				scan_mod = 1

			scan_key = clamp(scan_key,0,scan_dir_length)

			owner.set_dir(valid_scan_dirs[scan_key])
			last_scan = world.time



/ai/turret/deployable
	var/mob/living/simple/turret/deployable/owner_as_turret

/ai/turret/deployable/New(var/mob/living/desired_owner)
	. = ..()
	owner_as_turret = owner
	return .


/ai/turret/deployable/should_life()

	var/obj/item/powercell/B = owner_as_turret.get_battery()
	if(!B)
		return FALSE

	if(B.charge_current <= 0)
		return FALSE

	B.charge_current = max(B.charge_current - AI_TICK,0)

	return ..()
