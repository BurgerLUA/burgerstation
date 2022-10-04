SUBSYSTEM_DEF(ball) //Finally. A subsystem dedicated to BALLS.
	name = "Ball Subsystem"
	desc = "Controls how balls behave."
	tick_rate = 1
	priority = SS_ORDER_LAST

	tick_usage_max = 95

	use_time_dialation = FALSE

	var/list/all_balls = list()

/subsystem/ball/on_life()

	for(var/k in all_balls)
		var/obj/item/ball/B = k
		B.ball_think(tick_rate)
		CHECK_TICK_SAFE(tick_usage_max,FPS_SERVER)

	return TRUE


