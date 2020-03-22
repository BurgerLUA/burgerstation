/ai/dummy/
	objective_delay = 10
	attack_delay = 10

	stationary = FALSE
	use_alerts = FALSE

/ai/dummy/handle_objectives()
	return FALSE

/ai/dummy/handle_movement()
	if(owner.loc != start_turf)
		owner.move_dir = get_dir(owner,start_turf)
	else
		owner.move_dir = 0x0

/ai/dummy/handle_attacking()
	return FALSE