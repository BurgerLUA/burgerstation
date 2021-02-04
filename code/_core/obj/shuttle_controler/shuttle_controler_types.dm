


/obj/shuttle_controller/alpha
	name = "alpha shuttle controler"
	desc = "Controls the alpha shuttle."

	transit_start = /area/transit/dropship/alpha/station
	transit_bluespace = /area/transit/dropship/alpha/bluespace
	transit_end = /area/transit/dropship/alpha/landing

	status_id = "alpha"

/obj/shuttle_controller/bravo
	name = "bravo shuttle controler"
	desc = "Controls the bravo shuttle."

	transit_start = /area/transit/dropship/bravo/station
	transit_bluespace = /area/transit/dropship/bravo/bluespace
	transit_end = /area/transit/dropship/bravo/landing

	status_id = "bravo"

/obj/shuttle_controller/charlie
	name = "charlie shuttle controler"
	desc = "Controls the charlie shuttle."

	transit_start = /area/transit/dropship/charlie/station
	transit_bluespace = /area/transit/dropship/charlie/bluespace
	transit_end = /area/transit/dropship/charlie/landing

	status_id = "charlie"

/obj/shuttle_controller/charlie/transit(var/starting_transit_id,var/ending_transit_id)

	if(ending_transit_id != /area/transit/dropship/charlie/station)
		var/area/A = get_area(src)
		for(var/obj/structure/interactive/ore_storage/OS in A.contents)
			stop_thinking(OS)
			OS.update_sprite()

	. = ..()


	if(. && ending_transit_id == /area/transit/dropship/charlie/station)
		var/area/A = get_area(src)
		for(var/obj/structure/interactive/ore_storage/OS in A.contents)
			start_thinking(OS)
			OS.update_sprite()

	return .

/obj/shuttle_controller/delta
	name = "delta shuttle controler"
	desc = "Controls the delta shuttle."

	transit_start = /area/transit/dropship/delta/station
	transit_bluespace = /area/transit/dropship/delta/bluespace
	transit_end = /area/transit/dropship/delta/landing

	status_id = "delta"

/*
/obj/shuttle_controller/delta/transit(var/starting_transit_id,var/ending_transit_id)

	if(starting_transit_id == "delta_shuttle_landing")
		var/obj/structure/interactive/fulton_beacon/B = locate() in get_area(src)
		if(B)
			var/turf/T = get_turf(B)
			if(T)
				for(var/k in fulton_devices)
					var/obj/item/clothing/back/fulton/F = k
					F.try_extract(T)

	return ..()
*/