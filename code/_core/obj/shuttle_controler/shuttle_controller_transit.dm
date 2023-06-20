/obj/shuttle_controller/proc/transit(var/obj/marker/shuttle_landing/desired_marker,var/accelerating=FALSE)

	var/list/areas_to_upate = list()

	var/turf/starting_turf = get_turf(src) //Shuttle controller loc.
	var/obj/marker/shuttle_landing/starting_landing_marker = locate() in starting_turf.contents //Where we are currently.
	if(!starting_landing_marker)
		CRASH("SHUTTLE ERROR: Could not find a shuttle landing marker!")
		return FALSE

	var/area/starting_area = starting_turf.loc

	if(!istype(starting_area,/area/shuttle)) //marker exists outside a shuttle area
		CRASH("SHUTTLE ERROR: [src.get_debug_name()] is not in a valid shuttle area!")
		return FALSE

	var/transit_throw_x = 0
	var/transit_throw_y = 0
	switch(src.dir)
		if(NORTH)
			transit_throw_y += accelerating ? -1 : 1
		if(EAST)
			transit_throw_x += accelerating ? -1 : 1
		if(SOUTH)
			transit_throw_y -= accelerating ? -1 : 1
		if(WEST)
			transit_throw_x -= accelerating ? -1 : 1

	var/list/atom/movable/objects_to_throw = list()

	var/list/valid_turfs = list()

	for(var/turf/simulated/T in starting_area) //This is needed or else thing will be buggy.
		valid_turfs += T
		CHECK_TICK(75,FPS_SERVER)

	var/original_src_x = src.x
	var/original_src_y = src.y

	for(var/j in valid_turfs) //First pass: Stun everything.
		var/turf/T = j
		for(var/k in T.contents)
			var/atom/movable/M = k
			M.next_move = max(M.next_move,SECONDS_TO_TICKS(4))
			CHECK_TICK(75,FPS_SERVER)
		CHECK_TICK(75,FPS_SERVER)

	//First pass. Crush everything and add new turfs.
	for(var/j in valid_turfs) //Valid turfs are all the turfs in the shuttle area.
		var/turf/T = j
		var/offset_x = T.x - original_src_x
		var/offset_y = T.y - original_src_y
		var/turf/T_to_replace = locate(desired_marker.x + offset_x, desired_marker.y + offset_y, desired_marker.z) //The destination turf!
		if(!T_to_replace)
			log_error("Shuttle Warning: Could not find a turf to replace for [src.get_debug_name()] at T: [T.x],[T.y],[T.z] | SRC: [original_src_x],[original_src_y],[T.z].")
			valid_turfs -= T
			continue

		if(!T_to_replace.stored_shuttle_items)
			T_to_replace.stored_shuttle_items = list() //Create the list it needs to store shuttle items.

		if(is_simulated(T_to_replace)) //Crush everything in the destination turf that's attached. First pass.
			var/turf/simulated/S = T_to_replace
			for(var/k in S.linked_attachments)
				var/obj/structure/O = k
				if(!O || O.qdeleting)
					continue
				O.on_crush()
				if(!O.qdeleting)
					log_error("Warning: [O.get_debug_name()] was a crushed attached object, but it's not deleting!")
				CHECK_TICK(75,FPS_SERVER)

		for(var/k in T_to_replace.contents) //Crush everything in the destination turf. First pass.
			var/atom/movable/M = k
			if(!M.density)
				continue
			if(is_living(M))
				var/mob/living/L = M
				if(T_to_replace.density_down && T_to_replace.health)
					T_to_replace.on_destruction(TRUE)
				L.Move(T_to_replace) //Update
				if(L.loc == T_to_replace) //Still on the same location.
					var/obj/projectile/thrown/P = M.throw_self(M,vel_x=-transit_throw_x*16,vel_y=-transit_throw_y*16)
					if(P) P.ignore_shuttles = TRUE
			else
				M.on_crush()
			CHECK_TICK(75,FPS_SERVER)

		for(var/k in T_to_replace.contents)
			var/atom/movable/M = k
			if(!M || M.qdeleting)
				continue
			if(!M.density || M.anchored >= 2)
				continue
			T_to_replace.stored_shuttle_items += M
			M.force_move(src) //Stored in the shuttle controller, for now.
			CHECK_TICK(75,FPS_SERVER)

		var/turf/old_turf_type = T_to_replace.type
		var/area/old_area_type = T_to_replace.loc.type


		areas_to_upate[T.loc] = TRUE
		T_to_replace.change_area(T.loc.type) //Change to destination area to shuttle area.
		areas_to_upate[T.loc] = TRUE

		if(T.plane == PLANE_SHUTTLE)
			T_to_replace.change_turf(T.type,TRUE,TRUE) //Change destination turf to shuttle turf.

		T_to_replace.transit_turf = old_turf_type
		T_to_replace.transit_area = old_area_type

	//Second pass. Move everything from source to destination.
	for(var/j in valid_turfs) //Valid turfs are all the turfs in the shuttle area.
		var/turf/T = j
		var/offset_x = T.x - original_src_x
		var/offset_y = T.y - original_src_y
		var/turf/T_to_replace = locate(desired_marker.x + offset_x, desired_marker.y + offset_y, desired_marker.z) //The destination turf!
		if(!T_to_replace)
			log_error("Shuttle Warning: Could not find a turf to replace for [src.get_debug_name()] at T: [T.x],[T.y],[T.z] | SRC: [original_src_x],[original_src_y],[T.z].")
			continue

		//Move attached objects.
		if(is_simulated(T))
			var/turf/simulated/S = T
			for(var/k in S.linked_attachments)
				var/obj/structure/O = k
				var/offset_move_x = T_to_replace.x + (O.x - O.attached_to.x)
				var/offset_move_y = T_to_replace.y + (O.y - O.attached_to.y)
				var/turf/T_to_move_to = locate(offset_move_x,offset_move_y, T_to_replace.z) //The destination turf!
				if(!T_to_move_to || !is_simulated(T_to_replace))
					log_error("ERROR: [offset_move_x],[offset_move_y],[T_to_replace.z] was not a valid simulated turf to attach [O.get_debug_name()] to!")
					qdel(O)
					continue
				var/turf/simulated/S_to_replace = T_to_replace
				S.unattach(O)
				O.force_move(T_to_move_to)
				S_to_replace.attach(O)
				CHECK_TICK(75,FPS_SERVER)

		//Move contents.
		for(var/k in T.contents)
			var/atom/movable/M = k
			if(M.anchored >= 2)
				continue
			if(M.loc != T)
				continue
			M.force_move(T_to_replace)
			if(enable_shuttle_throwing)
				objects_to_throw += M
			CHECK_TICK(75,FPS_SERVER)

		//Move stored shuttle items.
		for(var/k in T.stored_shuttle_items)
			var/atom/movable/M = k
			if(is_item(M))
				var/obj/item/I = M
				I.drop_item(T)
			else
				M.force_move(T)
			T.stored_shuttle_items -= M
			CHECK_TICK(75,FPS_SERVER)

		areas_to_upate[T.loc] = TRUE
		T.change_area(T.transit_area) //From shuttle area to old turf that existed under.
		areas_to_upate[T.loc] = TRUE

		//"Delete" old turf.
		if(T.plane == PLANE_SHUTTLE)
			T.change_turf(T.transit_turf) //From shuttle turf to old turf that existed under.

		CHECK_TICK(75,FPS_SERVER)

	for(var/k in areas_to_upate)
		var/area/A = k
		A.generate_average()

	if(enable_shuttle_throwing)
		for(var/k in objects_to_throw)
			var/atom/movable/M = k
			if(M.anchored || M.collision_flags & FLAG_COLLISION_ETHEREAL)
				continue
			if(istype(M,/obj/structure/))
				continue
			if(is_living(M) && locate(/obj/structure/interactive/chair) in M.loc.contents)
				continue
			M.throw_self(M,vel_x=transit_throw_x*8,vel_y=transit_throw_y*8)
			CHECK_TICK(75,FPS_SERVER)

	starting_landing_marker.set_reserved(FALSE)

	return TRUE