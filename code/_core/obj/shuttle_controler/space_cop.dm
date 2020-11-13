/obj/shuttle_controller/space_cop
	name = "space cop shuttle controler"
	desc = "Controls the space cop shuttle."

	transit_start = /area/transit/space_cop/station
	transit_bluespace = /area/transit/space_cop/bluespace
	transit_end = /area/transit/space_cop/landing

	default_transit_time = 10
	default_waiting_time = 5

/obj/shuttle_controller/space_cop/transit(var/starting_transit_id,var/ending_transit_id)

	. = ..()

	if(.)

		if(ending_transit_id == transit_end)

			var/area/A = get_area(src)

			var/list/possible_destinations = list()
			for(var/k in all_remote_flight_consoles)
				var/obj/structure/interactive/computer/console/remote_flight/RF = k
				var/area/A2 = get_area(RF)
				if(A2.area_identifier != "Mission")
					continue
				possible_destinations += k

			if(!length(possible_destinations))
				log_error("Space Cops Path Error: Couldn't find a shuttle controller to go to!")
				announce("Space Cops","Space Cops Investigation","We currently arrived at the LZ. We've parked our ship in a secure area, please do not distrub us.")
				return .

			var/obj/structure/interactive/computer/console/remote_flight/RF = pick(possible_destinations)

			var/area/A2 = get_area(RF)

			var/obj/marker/map_node/N_end = find_closest_node(RF)

			if(!N_end)
				log_error("Space Cops Path Error: Couldn't find closet node to [RF]!")
				announce("Space Cops","Space Cops Investigation","We currently arrived at the LZ. We've parked our ship in a secure area, please do not distrub us.")
				return .

			announce("Space Cops","Space Cops Investigation","We currently arrived at the LZ, and are begining our investigation at [A2.name].")

			for(var/mob/living/L in A.contents)
				if(L.loyalty_tag != "Space Cop")
					continue
				if(!L.ai)
					continue
				if(L.dead)
					continue
				var/obj/marker/map_node/N_start = find_closest_node(L)
				if(!N_start)
					log_error("Space Cops Path Error: Couldn't find closet node to [L.get_debug_name()]!")
					return .
				var/obj/marker/map_node/list/found_path = N_start.find_path(N_end)
				if(!found_path || !length(found_path))
					log_error("Space Cops Path Error: Couldn't find a path from [src] to [RF]!")
					return .
				L.ai.set_path(found_path)

		if(ending_transit_id == transit_start)
			var/area/A = get_area(src)
			for(var/mob/living/L in A.contents)
				qdel(L)



	return .