/obj/shuttle_controller/arrivals
	name = "arrivals shuttle controler"
	desc = "Controls the arrivals shuttle."

	transit_start = "arrivals_shuttle_centcomm"
	transit_bluespace = "arrivals_shuttle_bluespace"
	transit_end = "arrivals_shuttle_station"

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


/obj/shuttle_controller/alpha
	name = "alpha shuttle controler"
	desc = "Controls the alpha shuttle."

	transit_start = "alpha_shuttle_station"
	transit_bluespace = "alpha_shuttle_bluespace"
	transit_end = "alpha_shuttle_landing"

/obj/shuttle_controller/bravo
	name = "bravo shuttle controler"
	desc = "Controls the bravo shuttle."

	transit_start = "bravo_shuttle_station"
	transit_bluespace = "bravo_shuttle_bluespace"
	transit_end = "bravo_shuttle_landing"

/obj/shuttle_controller/charlie
	name = "charlie shuttle controler"
	desc = "Controls the charlie shuttle."

	transit_start = "charlie_shuttle_station"
	transit_bluespace = "charlie_shuttle_bluespace"
	transit_end = "charlie_shuttle_landing"

/obj/shuttle_controller/charlie/transit(var/starting_transit_id,var/ending_transit_id)

	if(ending_transit_id != "charlie_shuttle_station")
		var/area/A = get_area(src)
		for(var/obj/structure/interactive/ore_storage/OS in A.contents)
			stop_thinking(OS)
			OS.update_icon()

	. = ..()

	if(.)
		if(ending_transit_id == "charlie_shuttle_station")
			var/area/A = get_area(src)
			for(var/obj/structure/interactive/ore_storage/OS in A.contents)
				start_thinking(OS)
				OS.update_icon()

	return .

/obj/shuttle_controller/delta
	name = "delta shuttle controler"
	desc = "Controls the delta shuttle."

	transit_start = "delta_shuttle_station"
	transit_bluespace = "delta_shuttle_bluespace"
	transit_end = "delta_shuttle_landing"

/obj/shuttle_controller/syndicate
	name = "syndicate shuttle controler"
	desc = "Controls the syndicate shuttle."

	transit_start = "syndicate_shuttle_centcomm"
	transit_bluespace = "syndicate_shuttle_bluespace"
	transit_end = "syndicate_shuttle_station"


/obj/shuttle_controller/cargo
	name = "cargo shuttle controler"
	desc = "Controls the cargo shuttle."

	transit_start = "cargo_shuttle_station"
	transit_bluespace = "cargo_shuttle_bluespace"
	transit_end = "cargo_shuttle_planet"


/obj/shuttle_controller/cargo/transit(var/starting_transit_id,var/ending_transit_id)

	. = ..()

	if(. && ending_transit_id == "cargo_shuttle_planet")
		var/area/A = get_area(src)
		var/total_value = 0
		for(var/atom/movable/M in A.contents)
			var/calculated_value = M.calculate_value()
			if(M.qdeleting || calculated_value <= 0)
				continue
			total_value += M.calculate_value()
			qdel(M)

		stored_payday += total_value

	return .

/obj/shuttle_controller/cargo/on_shuttle_think()

	if(state == SHUTTLE_STATE_LANDED)
		display = "Landed"
		if(time >= 100)
			state = SHUTTLE_STATE_WAITING
			time = 0

	return ..()