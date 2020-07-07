/obj/shuttle_controller/cargo
	name = "cargo shuttle controler"
	desc = "Controls the cargo shuttle."

	transit_start = "cargo_shuttle_station"
	transit_bluespace = "cargo_shuttle_bluespace"
	transit_end = "cargo_shuttle_planet"

	status_id = "cargo"

	default_waiting_time = 10
	default_transit_time = 10

/obj/shuttle_controller/cargo/transit(var/starting_transit_id,var/ending_transit_id)

	if(ending_transit_id == "cargo_shuttle_planet")
		var/area/A = get_area(src)
		var/total_value = 0
		for(var/atom/movable/O in A.contents)
			if(!isobj(O) && !ismob(O))
				continue
			if(!O.is_safe_to_delete())
				continue
			if(is_living(O))
				var/mob/living/L = O
				if(!L.dead && L.loyalty_tag == "NanoTrasen")
					continue
			var/calculated_value = CEILING(O.calculate_value(),1)
			if(calculated_value <= 0)
				continue
			total_value += calculated_value
			if(is_living(O))
				var/mob/living/L = O
				L.death()
			qdel(O)

		SSpayday.stored_payday += total_value

	return ..()

/obj/shuttle_controller/cargo/on_shuttle_think()

	if(state == SHUTTLE_STATE_LANDED)
		display = "Dock"
		if(time >= SHUTTLE_DEFAULT_IDLE_TIME)
			state = SHUTTLE_STATE_WAITING
			time = 0

	return ..()