/obj/shuttle_controller/arrivals
	name = "arrivals shuttle controler"
	desc = "Controls the arrivals shuttle."

	transit_start = "arrivals_shuttle_centcomm"
	transit_bluespace = "arrivals_shuttle_bluespace"
	transit_end = "arrivals_shuttle_station"

/obj/shuttle_controller/cargo
	name = "cargo shuttle controler"
	desc = "Controls the cargo shuttle."

	transit_start = "cargo_shuttle_station"
	transit_bluespace = "cargo_shuttle_bluespace"
	transit_end = "cargo_shuttle_planet"



/obj/shuttle_controller/arrivals/on_shuttle_think()

	if(state == SHUTTLE_STATE_LANDED)
		display = "Landed"
		if(time >= 100)
			var/area/A = get_area(src)
			if(A.id == transit_end)
				state = SHUTTLE_STATE_WAITING
				time = 0
			else
				var/mob/P = locate() in A.contents
				if(P)
					state = SHUTTLE_STATE_WAITING
					time = 0

	return ..()