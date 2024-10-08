/obj/shuttle_controller/lz420_elevator
	name = "elevator"

	transit_start = /area/transit/lz420_elevator/surface
	transit_bluespace = /area/transit/lz420_elevator/middle
	transit_end = /area/transit/lz420_elevator/basement

	status_id = "lz420_elevator"

	default_transit_time = 10
	default_waiting_time = 5

	start_sound = 'sound/effects/elevator_openclose.ogg'
	progress_sound = 'sound/effects/elevator_move.ogg'
	end_sound = 'sound/effects/elevator_openclose.ogg'

	enable_shuttle_throwing = FALSE

	time_restricted = FALSE