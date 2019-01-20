/datum/macros/
	var/client/owner
	var/list/macros = list(
		"W" = NORTH,
		"D" = EAST,
		"S" = SOUTH,
		"A" = WEST,
		"T" = "say",
		"E" = "grab",
		"Shift" = "sprint",
		"Alt" = "walk",
		"Ctrl" = "crouch",
		"R" = "throw",
		"Q" = "drop",
		"Space" = "kick"
	)

/datum/macros/New(var/client/spawning_owner)
	owner = spawning_owner

/datum/macros/proc/on_pressed(button)
	var/command = macros[button]

	if(isnum(command))
		owner.mob.move_dir |= command
	else
		switch(command)
			if("sprint")
				owner.mob.movement_flags |= MOVEMENT_RUNNING
			if("walk")
				owner.mob.movement_flags |= MOVEMENT_WALKING
			if("crouch")
				owner.mob.movement_flags |= MOVEMENT_CROUCHING
			if("throw")
				owner.mob.attack_flags |= ATTACK_THROW
			if("drop")
				owner.mob.attack_flags |= ATTACK_DROP
			if("kick")
				owner.mob.attack_flags |= ATTACK_KICK
			if("grab")
				owner.mob.attack_flags |= ATTACK_GRAB

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
			if("throw")
				owner.mob.attack_flags &= ~ATTACK_THROW
			if("drop")
				owner.mob.attack_flags &= ~ATTACK_DROP
			if("kick")
				owner.mob.attack_flags &= ~ATTACK_KICK
			if("grab")
				owner.mob.attack_flags &= ~ATTACK_GRAB

	return TRUE