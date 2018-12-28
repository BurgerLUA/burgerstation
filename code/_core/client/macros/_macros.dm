/datum/macros/
	var/client/owner
	var/list/macros = list(
		"W" = NORTH,
		"D" = EAST,
		"S" = SOUTH,
		"A" = WEST
	)

/datum/macros/New(var/client/spawning_owner)
	owner = spawning_owner

/datum/macros/proc/on_pressed(button)
	var/command = macros[button]

	if(isnum(command))
		owner.mob.move_dir |= command
		owner.mob.handle_movement()

	return TRUE

/datum/macros/proc/on_released(button)
	var/command = macros[button]

	if(isnum(command))
		owner.mob.move_dir &= ~command


	return TRUE