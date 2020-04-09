SUBSYSTEM_DEF(lag_b_gone)
	name = "Lag-B-Gone Subsystem"
	desc = "Controls how fast everything runs. Slows down subsystems if they lag."
	tick_rate = SECONDS_TO_TICKS(1)
	priority = SS_ORDER_IMPORTANT

	var/was_active = FALSE

	var/fps_decrease = 0

/subsystem/lag_b_gone/on_life()

	if(world.tick_usage >= 75)
		fps_decrease = max(FPS_SERVER_MIN,fps_decrease-1)
	else if (world.tick_usage <= 25)
		fps_decrease = min(fps_decrease+1,FPS_SERVER)

	if(fps_decrease < 0 && !was_active)
		broadcast_to_clients("Lag-B-Gone is now active.")
		was_active = TRUE
	else if(fps_decrease >= 0 && was_active)
		broadcast_to_clients("Lag-B-Gone is now inactive.")
		was_active = FALSE

	return TRUE