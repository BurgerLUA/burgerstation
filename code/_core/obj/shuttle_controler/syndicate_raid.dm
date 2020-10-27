/obj/shuttle_controller/syndicate_raid
	name = "syndicate raid shuttle controler"
	desc = "Controls the syndicate raid shuttle."

	transit_start = /area/transit/syndicate_raid/centcomm
	transit_bluespace = /area/transit/syndicate_raid/bluespace
	transit_end = /area/transit/syndicate_raid/ship

	status_id = "syndicate_raid"

	default_transit_time = SHUTTLE_DEFAULT_TRANSIT_TIME
	default_waiting_time = 5

/obj/shuttle_controller/syndicate_raid/transit(var/starting_transit_id,var/ending_transit_id)

	. = ..()

	if(ending_transit_id == /area/transit/syndicate_raid/ship)
		spook_station()

		var/area/A = get_area(src)

		for(var/obj/marker/explosion_point/MP in A.contents)
			explode(get_turf(MP),4,null,MP,"Syndicate")

	return .