/obj/shuttle_controller/cargo
	name = "cargo shuttle controler"
	desc = "Controls the cargo shuttle."

	transit_start = "cargo_shuttle_station"
	transit_bluespace = "cargo_shuttle_bluespace"
	transit_end = "cargo_shuttle_planet"

	status_id = "cargo"

/obj/shuttle_controller/cargo/proc/is_safe_delete(var/atom/A)

	if(istype(A,/obj/overlay/)) //Ignore
		return TRUE

	if(A.qdeleting)
		return FALSE

	if(ismob(A))
		var/mob/M = A
		if(M.client || M.ckey_last)
			return FALSE

	if(!(istype(A,/obj/item/) || istype(A,/obj/structure/) || istype(A,/obj/hud/inventory)))
		return FALSE

	for(var/atom/A2 in A.contents)
		if(!is_safe_delete(A2))
			return FALSE

	return TRUE

/obj/shuttle_controller/cargo/transit(var/starting_transit_id,var/ending_transit_id)

	if(ending_transit_id == "cargo_shuttle_planet")
		var/area/A = get_area(src)
		var/total_value = 0
		for(var/obj/O in A.contents)
			if(!is_safe_delete(O))
				continue
			var/calculated_value = CEILING(O.calculate_value(),1)
			if(calculated_value <= 0)
				continue
			total_value += calculated_value
			qdel(O)

		stored_payday += total_value

	return ..()

/obj/shuttle_controller/cargo/on_shuttle_think()

	if(state == SHUTTLE_STATE_LANDED)
		display = "Dock"
		if(time >= SHUTTLE_DEFAULT_IDLE_TIME)
			state = SHUTTLE_STATE_WAITING
			time = 0

	return ..()