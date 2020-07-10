


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
			OS.update_sprite()

	. = ..()


	if(. && ending_transit_id == "charlie_shuttle_station")
		var/area/A = get_area(src)
		for(var/obj/structure/interactive/ore_storage/OS in A.contents)
			start_thinking(OS)
			OS.update_sprite()

	return .

/obj/shuttle_controller/delta
	name = "delta shuttle controler"
	desc = "Controls the delta shuttle."

	transit_start = "delta_shuttle_station"
	transit_bluespace = "delta_shuttle_bluespace"
	transit_end = "delta_shuttle_landing"

/*
/obj/shuttle_controller/delta/transit(var/starting_transit_id,var/ending_transit_id)

	if(starting_transit_id == "delta_shuttle_landing")
		var/obj/structure/interactive/fulton_beacon/B = locate() in get_area(src)
		if(B)
			var/turf/T = get_turf(B)
			if(T)
				for(var/obj/item/clothing/back/fulton/F in fulton_devices)
					F.try_extract(T)

	return ..()
*/

/obj/shuttle_controller/golf
	name = "golf shuttle controler"
	desc = "Controls the golf shuttle."

	transit_start = "golf_shuttle_station"
	transit_bluespace = "golf_shuttle_bluespace"
	transit_end = "golf_shuttle_landing"
