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
		world.log << "Cannot sell the [A] as it is being deleted."
		return FALSE

	if(ismob(A))
		var/mob/M = A
		if(M.client || M.ckey_last)
			world.log << "Cannot sell the [M] as it contains a client."
			return FALSE

	if(!(istype(A,/obj/item/) || istype(A,/obj/structure/) || istype(A,/obj/hud/inventory)))
		world.log << "Cannot sell the [A] as it is not an /obj/item/ or an /obj/structure/, but a [A.type]."
		return FALSE

	for(var/atom/A2 in A.contents)
		if(!is_safe_delete(A2))
			world.log << "A [A2] was found inside [A] so it cannot be deleted."
			return FALSE

	return TRUE

/obj/shuttle_controller/cargo/transit(var/starting_transit_id,var/ending_transit_id)

	if(ending_transit_id == "cargo_shuttle_planet")
		var/area/A = get_area(src)
		var/total_value = 0
		for(var/obj/O in A.contents)
			if(!is_safe_delete(O))
				world.log << "Cannot sell \the [O.name]!"
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