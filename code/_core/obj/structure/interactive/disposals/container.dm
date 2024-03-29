#define BOTH_ANGLES(x) list(x.dir,turn(x.dir,180)

/obj/disposals_container
	name = "disposals container"
	desc = "If you are seeing this, then something went wrong."
	var/obj/structure/interactive/disposals/last_pipe
	var/sorting_tag
	var/sorting_tag_partial

	var/fail_times = 0

	var/list/visited_pipes = list()

/obj/disposals_container/PostInitialize()
	START_THINKING(src)
	return ..()

/obj/disposals_container/Exit(atom/movable/O, atom/newloc)
	return FALSE //NO ESCAPE

/obj/disposals_container/PreDestroy()

	var/turf/T = get_turf(src)

	for(var/k in contents)
		var/atom/movable/M = k
		M.force_move(T)

	. = ..()

/obj/disposals_container/Destroy()
	visited_pipes.Cut()
	last_pipe = null
	. = ..()

/obj/disposals_container/think()

	if(!istype(loc,/obj/structure/interactive/disposals/))
		qdel(src)
		return FALSE

	var/obj/structure/interactive/disposals/D = loc

	var/list/connected_pipes = D.get_connections()
	for(var/dir_string in connected_pipes) //Get all our connected pipes.
		var/dir_number = text2num(dir_string)
		if(!isnum(dir_number))
			continue
		var/passcode = connected_pipes[dir_string]
		if(!passcode)
			continue
		if(istext(passcode) && passcode != sorting_tag)
			continue
		if(sorting_tag && (!istext(passcode) || passcode != sorting_tag) && istype(D,/obj/structure/interactive/disposals/pipe/junction/sorting))
			var/obj/structure/interactive/disposals/pipe/junction/sorting/SJ = D
			if(sorting_tag == SJ.sorting_tag)
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
			if(get_dir(last_pipe,D) != get_dir(D,D2))
				play_sound(pick('sound/effects/disposals/clang1.ogg','sound/effects/disposals/clang2.ogg'),found_turf)
			if(last_pipe && visited_pipes[last_pipe])
				visited_pipes[last_pipe] += 1
				if(visited_pipes[last_pipe] >= 5)
					qdel(src)
					return TRUE
			else
				visited_pipes[last_pipe] = 1
			last_pipe = loc
			src.force_move(D2)
			return TRUE

	if(fail_times < 3 && last_pipe && !last_pipe.qdeleting)
		var/obj/structure/interactive/disposals/old_last_pipe = last_pipe
		if(visited_pipes[last_pipe])
			visited_pipes[last_pipe] += 1
			if(visited_pipes[last_pipe] >= 5)
				qdel(src)
				return TRUE
		else
			visited_pipes[last_pipe] = 1
		last_pipe = loc
		fail_times++
		src.force_move(old_last_pipe)
		return TRUE

	log_error("Disposal error: [src.loc.get_debug_name()].")
	for(var/atom/movable/M in src.contents)
		M.force_move(get_turf(src.loc))

	STOP_THINKING(src)

	qdel(src)

	return FALSE