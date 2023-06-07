/ai/bot/cleaner
	active = TRUE

	attack_obstacles = FALSE
	attack_movement_obstructions = FALSE

	aggression = 0
	assistance = 0

	cowardice = 1

	sleep_on_idle = FALSE

	frustration_move_threshold = 0

	var/turn_mode = 0
	var/turn_angle = 90

/ai/bot/cleaner/handle_movement()

	. = ..()

	if(.)
		return .

	if(turn_mode > 0)
		if(turn_mode % 2) //Every odd, turn and don't move.
			var/desired_dir = turn(owner.dir,turn_angle)
			owner.set_dir(desired_dir)
			if(turn_angle == 180 || turn_angle == -180)
				turn_angle = pick(-90.90)
			last_movement_proc = "turn"
			owner.movement_flags = MOVEMENT_WALKING
			owner.move_dir = 0x0
			turn_mode--
			return TRUE
		turn_mode--

	if(handle_movement_cleaning())
		last_movement_proc = "cleaning"
		return TRUE

/ai/bot/cleaner/proc/handle_movement_cleaning()
	owner.movement_flags = MOVEMENT_WALKING
	owner.move_dir = owner.dir
	return TRUE


/ai/bot/cleaner/on_movement_fail()

	. = ..()

	if(last_movement_proc == "cleaning")
		var/turf/T_right = get_step(owner,turn(owner.dir,-90))
		var/turf/T_left = get_step(owner,turn(owner.dir,90))

		if(!T_right || T_right.density || T_right.has_dense_atom)
			T_right = null

		if(!T_left || T_left.density || T_left.has_dense_atom)
			T_left = null

		if(T_right && T_left)
			turn_angle = -turn_angle
		else if(!T_right && !T_left)
			turn_angle = 180
		else if(T_right)
			turn_angle = -90
		else if(T_left)
			turn_angle = 90

		if(turn_mode <= 0)
			turn_mode = 3
		else
			turn_mode = 1