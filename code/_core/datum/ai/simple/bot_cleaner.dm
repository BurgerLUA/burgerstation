/ai/bot/cleaner
	active = TRUE

	shoot_obstacles = FALSE
	attack_movement_obstructions = FALSE

	aggression = 0
	assistance = 0

	cowardice = 1

	sleep_on_idle = FALSE

	frustration_move_threshold = 0

/ai/bot/cleaner/handle_movement()

	. = ..()

	if(.)
		return .

	if(handle_movement_cleaning())
		last_movement_proc = "cleaning"
		return TRUE

/ai/bot/cleaner/proc/handle_movement_cleaning()
	owner.movement_flags = MOVEMENT_WALKING
	owner.move_dir = owner.dir
	return TRUE