/obj/shuttle_controller/cargo
	name = "cargo shuttle controler"
	desc = "Controls the cargo shuttle."

	transit_start = /area/transit/cargo/ship
	transit_bluespace = /area/transit/cargo/bluespace
	transit_end = /area/transit/cargo/centcomm

	status_id = "cargo"

	default_waiting_time = 120
	default_transit_time = 10


/obj/shuttle_controller/cargo/proc/sell_items_in_area()

/obj/shuttle_controller/cargo/transit(var/starting_transit_id,var/ending_transit_id)

	if(ending_transit_id == /area/transit/cargo/centcomm)
		var/area/A = get_area(src)
		var/total_value = 0
		for(var/obj/structure/interactive/crate/C in A.contents)
			if(istype(C,/obj/structure/interactive/crate/secure))
				if(C.is_safe_to_delete(check_loc = FALSE))
					qdel(C)
			else
				C.open()
		for(var/atom/movable/O in A.contents)
			if(!(isobj(O) || ismob(O)))
				continue
			if(!O.is_safe_to_delete(check_loc = FALSE))
				continue
			if(is_living(O))
				var/mob/living/L = O
				if(!L.dead && L.loyalty_tag == "NanoTrasen")
					continue
			var/calculated_value = CEILING(O.get_value(),1)
			if(calculated_value <= 0)
				continue
			total_value += calculated_value
			if(is_living(O))
				var/mob/living/L = O
				if(!L.dead) L.death()
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