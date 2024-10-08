/obj/shuttle_controller/cargo_inbound
	name = "cargo inbound shuttle controler"
	desc = "Controls the cargo inbound shuttle."

	transit_start = /area/transit/cargo_inbound/ship
	transit_bluespace = /area/transit/cargo_inbound/bluespace
	transit_end = /area/transit/cargo_inbound/centcomm

	status_id = "cargo_inbound"

	default_waiting_time = 60
	default_transit_time = 10

/obj/shuttle_controller/cargo_inbound/transit(var/starting_transit_id,var/ending_transit_id)

	return ..()

/obj/shuttle_controller/cargo_inbound/on_shuttle_think()

	if(state == SHUTTLE_STATE_LANDED)
		display = "Dock"
		if(time >= SHUTTLE_DEFAULT_IDLE_TIME)
			state = SHUTTLE_STATE_WAITING
			time = 0

	return ..()