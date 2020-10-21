#define BOTH_ANGLES(x) list(x.dir,turn(x.dir,180)

/obj/disposals_container
	name = "disposals container"
	desc = "If you are seeing this, then something went wrong."
	var/obj/structure/interactive/disposals/last_pipe
	var/sorting_tag

/obj/disposals_container/PostInitialize()
	start_thinking(src)
	return ..()

/obj/disposals_container/Exit(atom/movable/O, atom/newloc)
	return FALSE //NO ESCAPE

/obj/disposals_container/Destroy()

	for(var/k in contents)
		var/atom/movable/M = k
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
		qdel(src)
		return FALSE

	var/obj/structure/interactive/disposals/D = loc

	var/list/connected_pipes = D.get_connections()
	for(var/dir_string in connected_pipes)
		var/dir_number = text2num(dir_string)
		if(!isnum(dir_number))
			continue
		var/passcode = connected_pipes[dir_string]
		if(!passcode)
			continue
		if(istext(passcode) && passcode != sorting_tag)
			continue
		if(sorting_tag && sorting_tag == D.sorting_tag && (!istext(passcode) || passcode != sorting_tag))
			continue
		var/turf/found_turf = get_step(src,dir_number) //GOING INTO THIS PIPE!
		for(var/obj/structure/interactive/disposals/D2 in found_turf.contents)
			if(D2 == D)
				continue
			if(last_pipe == D2)
				continue
			var/list/connected_pipes_2 = D2.get_connections()
			var/desired_dir = dir_number ? turn(dir_number,180) : 0
			if(isnull(connected_pipes_2["[desired_dir]"]))
				continue
			move_to_pipe(D2)
			return TRUE

	log_error("Disposal error: [src.loc.get_debug_name()].")
	for(var/atom/movable/M in src.contents)
		M.force_move(get_turf(src.loc))

	stop_thinking(src)

	return FALSE