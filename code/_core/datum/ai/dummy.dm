/ai/dummy/
	name = "Dummy AI"
	desc = "Does not attack. Moves back to starting position when it can."

	objective_delay = 10
	attack_delay = 10
	movement_delay = 10

	sync_movement_delay = TRUE
	stationary = FALSE

/ai/dummy/handle_objectives()
	return FALSE

/ai/dummy/handle_movement()
	if(owner.loc != start_turf)
		owner.move_dir = get_dir(owner,start_turf)
	else
		owner.move_dir = 0x0

/ai/dummy/handle_attacking()
	return FALSE