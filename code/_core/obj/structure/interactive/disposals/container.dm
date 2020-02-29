#define BOTH_ANGLES(x) list(x.dir,turn(x.dir,180)

/obj/disposals_container
	name = "disposals container"
	desc = "If you are seeing this, then something went wrong."
	var/obj/structure/interactive/disposals/last_pipe
	var/sorting_tag

/obj/disposals_container/Initialize()
	start_thinking(src)
	return ..()

/obj/disposals_container/Destroy()

	for(var/atom/movable/M in contents)
		if(M.collision_flags & FLAG_COLLISION_ETHEREAL)
			M.force_move(get_turf(src))
			continue
		var/list/offset = direction_to_pixel_offset(pick(DIRECTIONS_ALL))
		M.throw_self(M,null,null,null,offset[1]*10,offset[2]*10)

	return ..()


/obj/disposals_container/proc/move_to_pipe(var/obj/structure/interactive/disposals/D)
	last_pipe = loc
	src.force_move(D)
	return TRUE

/obj/disposals_container/think()

	if(!istype(loc,/obj/structure/interactive/disposals/))
		LOG_ERROR("WARNING: Disposal Container wasn't located in a pipe!")
		qdel(src)
		return FALSE

	var/obj/structure/interactive/disposals/D = loc

	//Check which part of the pipe to move OUT of.
	var/list/connected_pipes = D.get_connections()
	//print_list("Connected Pipes",connected_pipes)

	world.log << "Starting check for [D.name] ([D.type])."
	for(var/dir_string in connected_pipes)
		var/dir_number = text2num(dir_string)
		if(!isnum(dir_number))
			LOG_ERROR("NOT A NUMBER!")
			continue
		world.log << "STEP 1: Checking connected_pipe [direction_to_text(dir_number)]..."
		var/passcode = connected_pipes[dir_string]
		if(!passcode)
			LOG_ERROR("YOU CAN'T GET OUT THAT WAY!")
			continue

		if(istext(passcode) && passcode != sorting_tag)
			LOG_ERROR("Wrong passcode.")
			continue

		if(sorting_tag && sorting_tag == D.sorting_tag && (!istext(passcode) || passcode != sorting_tag))
			LOG_ERROR("NO, GO THROUGH THAT DOOR INSTEAD!")
			continue

		var/turf/found_turf = get_step(src,dir_number) //GOING INTO THIS PIPE!
		for(var/obj/structure/interactive/disposals/D2 in found_turf)
			world.log << "STEP 2: Checking connected_pipes_2 [direction_to_text(dir_number)]..."
			if(D2 == D)
				LOG_ERROR("SAME PIPE!")
				continue
			if(last_pipe == D2)
				LOG_ERROR("SAME PIPE AS LAST!")
				continue
			var/list/connected_pipes_2 = D2.get_connections()
			var/desired_dir = dir_number ? turn(dir_number,180) : 0
			if(isnull(connected_pipes_2["[desired_dir]"]))
				LOG_ERROR("CAN'T PHYSICALLY CONNECT TO THIS, AS IT DOESN'T HAVE A [direction_to_text(desired_dir)]([desired_dir]) CONNECTION")
				continue
			world.log << "STEP: 3 Moving to [dir_number]."
			move_to_pipe(D2)
			return TRUE

	stop_thinking(src)

	return FALSE