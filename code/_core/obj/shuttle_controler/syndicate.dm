/obj/shuttle_controller/syndicate
	name = "syndicate shuttle controler"
	desc = "Controls the syndicate shuttle."

	transit_start = "syndicate_shuttle_centcomm"
	transit_bluespace = "syndicate_shuttle_bluespace"
	transit_end = "syndicate_shuttle_planet"

	default_transit_time = SHUTTLE_DEFAULT_TRANSIT_TIME
	default_waiting_time = SHUTTLE_DEFAULT_WAITING_TIME * 0.5

/obj/shuttle_controller/syndicate/on_shuttle_think()

	if(state == SHUTTLE_STATE_LANDED)
		display = "Landed"
		if(time >= 100)
			state = SHUTTLE_STATE_WAITING
			time = 0

	return ..()


/obj/shuttle_controller/syndicate/transit(var/starting_transit_id,var/ending_transit_id)

	. = ..()

	if(.)

		world.log << "Starting: [starting_transit_id]."
		world.log << "Ending: [ending_transit_id]."

		if(starting_transit_id == "syndicate_shuttle_centcomm" && ending_transit_id == "syndicate_shuttle_bluespace")

			world.log << "RUNNING PART 1"

			var/area/A = get_area(src)
			var/list/mob/living/mobs_to_delete = list()
			var/list/mob/living/found_syndicate = list()

			for(var/mob/living/L in A.contents)
				if(!L.dead && L.client)
					world.log << "FOUND LIVING WITH CLIENT. RETURNING."
					return .
				if(L.iff_tag == "Syndicate")
					found_syndicate += L
				else if(!is_player(L))
					mobs_to_delete += L

			for(var/mob/living/L in mobs_to_delete)
				qdel(L)

			var/list/valid_spots = list()

			for(var/obj/structure/interactive/chair/C in A.contents)
				valid_spots += C.loc

			if(!length(valid_spots))
				world.log << "NO VALID SPOTS!"
				return .

			for(var/i=1,i<=5-length(found_syndicate),i++)
				var/turf/T = pick(valid_spots)
				valid_spots -= T
				var/mob/living/advanced/npc/syndicate/S = new(T)
				S.Initialize()
				if(i==1)
					for(var/mob/abstract/observer/O in world)
						O.force_move(T)
				sleep(-1)


		if(starting_transit_id == "syndicate_shuttle_bluespace" && ending_transit_id == "syndicate_shuttle_planet")

			world.log << "RUNNING PART 2"

			var/area/A = get_area(src)

			var/obj/marker/landmark/B = locate(pick("Bravo","Village"))

			if(!B || !B.loc)
				world.log << "There is no Bravo Landing Zone!"
				return .

			var/obj/map_node/N_end = find_closest_node(B)

			if(!N_end)
				world.log << "There is no N_end!"
				return .

			for(var/mob/living/L in A.contents)
				if(L.iff_tag != "Syndicate")
					continue
				if(!L.ai)
					continue

				var/obj/map_node/N_start = find_closest_node(L)
				if(!N_start)
					world.log << "NO START!"
					continue

				var/obj/map_node/list/found_path = N_start.find_path(N_end)

				if(!found_path || !length(found_path))
					world.log << "NO FOUND PATH!"
					continue

				L.ai.set_path(found_path)

	return .