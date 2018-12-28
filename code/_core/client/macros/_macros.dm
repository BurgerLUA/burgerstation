/datum/macros/
	var/client/owner
	var/list/macros = list(
		"W" = NORTH,
		"D" = EAST,
		"S" = SOUTH,
		"A" = WEST,
		"T" = "say",
		"Shift" = "sprint",
		"Alt" = "walk",
		"Ctrl" = "crouch"
	)

/datum/macros/New(var/client/spawning_owner)
	owner = spawning_owner

/datum/macros/proc/on_pressed(button)
	var/command = macros[button]

	if(isnum(command))
		owner.mob.move_dir |= command
		owner.mob.handle_movement()
	else
		switch(command)
			if("sprint")
				owner.mob.movement_flags |= MOVEMENT_RUNNING
			if("walk")
				owner.mob.movement_flags |= MOVEMENT_WALKING
			if("crouch")
				owner.mob.movement_flags |= MOVEMENT_CROUCHING

	return TRUE

/datum/macros/proc/on_released(button)
	var/command = macros[button]

	if(isnum(command))
		owner.mob.move_dir &= ~command
	else
		switch(command)
			if("say")
				owner.mob.say()
			if("sprint")
				owner.mob.movement_flags &= ~MOVEMENT_RUNNING
			if("walk")
				owner.mob.movement_flags &= ~MOVEMENT_WALKING
			if("crouch")
				owner.mob.movement_flags &= ~MOVEMENT_CROUCHING


	return TRUE