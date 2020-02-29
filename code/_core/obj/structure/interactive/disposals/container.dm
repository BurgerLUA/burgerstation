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

	if(last_pipe && last_pipe.disposals_container == src)
		last_pipe.disposals_container = null

	if(istype(src.loc,/obj/structure/interactive/disposals/))
		var/obj/structure/interactive/disposals/D = src.loc
		if(D.disposals_container == src)
			D.disposals_container = null

	last_pipe = null

	return ..()

/obj/disposals_container/think()

	if(!istype(loc,/obj/structure/interactive/disposals/))
		LOG_ERROR("WARNING: Disposal Container wasn't located in a pipe!")
		qdel(src)
		return FALSE

	var/obj/structure/interactive/disposals/D = loc

	if(sorting_tag != "none")
		for(var/obj/structure/interactive/disposals/P in D.connected_pipes)
			if(D.connected_pipes[P] != sorting_tag)
				continue
			if(P.disposals_container)
				continue
			D.disposals_container = null
			src.last_pipe = D
			src.force_move(P)
			P.disposals_container = src
			P.on_container_enter(src)
			return TRUE

	for(var/obj/structure/interactive/disposals/P in D.connected_pipes) //I want to move to P.
		if(P == src.last_pipe)
			continue
		if(P.disposals_container)
			continue
		D.disposals_container = null
		src.last_pipe = D
		src.force_move(P)
		P.disposals_container = src
		P.on_container_enter(src)
		return TRUE

	return FALSE