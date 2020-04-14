/obj/shuttle_controller/cargo
	name = "cargo shuttle controler"
	desc = "Controls the cargo shuttle."

	transit_start = "cargo_shuttle_station"
	transit_bluespace = "cargo_shuttle_bluespace"
	transit_end = "cargo_shuttle_planet"

	status_id = "cargo"

/proc/is_safe_to_remove(var/atom/A)

	if(istype(A,/obj/overlay/)) //Ignore overlays.
		return TRUE

	if(A.qdeleting)
		return FALSE

	if(is_living(A))
		var/mob/living/L = A
		if(L.client || (L.ckey_last && !L.dead))
			return FALSE
	else if(ismob(A))
		return FALSE

	if(!(istype(A,/obj/item/) || istype(A,/obj/structure/) || istype(A,/obj/hud/inventory)))
		return FALSE

	for(var/atom/A2 in A.contents)
		if(!is_safe_to_remove(A2))
			return FALSE

	return TRUE

/obj/shuttle_controller/cargo/transit(var/starting_transit_id,var/ending_transit_id)

	if(ending_transit_id == "cargo_shuttle_planet")
		var/area/A = get_area(src)
		var/total_value = 0
		for(var/obj/O in A.contents)
			if(!is_safe_to_remove(O))
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