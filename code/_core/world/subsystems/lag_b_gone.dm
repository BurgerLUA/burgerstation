var/global/lag_b_gone = 0

/subsystem/lag_b_gone/
	name = "Lag-B-Gone Subsystem"
	desc = "Controls how fast everything runs. Slows down subsystems if they lag."
	tick_rate = SECONDS_TO_TICKS(1)
	priority = SS_ORDER_IMPORTANT

	var/was_active = FALSE

/subsystem/lag_b_gone/on_life()

	if(world.tick_usage >= 75)
		lag_b_gone = min(lag_b_gone + 1,10)
	else if (world.tick_usage < 25)
		lag_b_gone = max(lag_b_gone - 1,0)

	if(lag_b_gone && !was_active)
		broadcast_to_clients("Lag-B-Gone is now active.")
		was_active = TRUE
	else if(!lag_b_gone && was_active)
		broadcast_to_clients("Lag-B-Gone is now inactive.")
		was_active = FALSE

	return TRUE