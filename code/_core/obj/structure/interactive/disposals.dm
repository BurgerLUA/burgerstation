#define BOTH_ANGLES(x) list(x.dir,turn(x.dir,180)

/obj/disposals_container
	name = "disposals container"
	desc = "If you are seeing this, then something went wrong."
	var/obj/structure/interactive/disposals/last_pipe

/obj/disposals_container/Initialize()
	start_thinking(src)
	return ..()

/obj/disposals_container/Destroy()

	for(var/atom/movable/M in contents)
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

/obj/structure/interactive/disposals/
	icon = 'icons/obj/structure/disposals.dmi'
	var/obj/disposals_container/disposals_container
	var/list/obj/structure/interactive/disposals/connected_pipes

	//Connection Info
	var/double_sided = FALSE
	var/connects_dir = FALSE
	var/connects_up = FALSE
	var/connects_down = FALSE

	anchored = TRUE

/obj/structure/interactive/disposals/proc/on_container_enter(var/obj/disposals_container/C)
	return TRUE

/obj/structure/interactive/disposals/Destroy()

	if(disposals_container)
		qdel(disposals_container)
		disposals_container = null

	return ..()

/obj/structure/interactive/disposals/Initialize()
	update_connections()
	return ..()

/obj/structure/interactive/disposals/New(var/desired_loc)
	connected_pipes = list()
	return ..()

/obj/structure/interactive/disposals/proc/update_connections()
	connected_pipes = get_connections()
	return TRUE

/obj/structure/interactive/disposals/proc/enter_pipe(var/atom/movable/M)

	if(!disposals_container)
		disposals_container = new(src)
		disposals_container.last_pipe = src
		disposals_container.Initialize()

	M.force_move(disposals_container)
	return TRUE

/obj/structure/interactive/disposals/proc/get_connection_dir()

	var/src_connections = 0x0

	if(double_sided && (src.dir in DIRECTIONS_CARDINAL))
		src_connections = src.dir | turn(src.dir,180)
	else
		src_connections = src.dir

	return src_connections

/obj/structure/interactive/disposals/proc/get_connections(var/src_connection_dir = get_connection_dir())

	. = list()

	if(connects_dir)
		for(var/desired_dir in DIRECTIONS_CARDINAL)
			if(!(src_connection_dir & desired_dir))
				continue
			var/turf/T = get_step(src,desired_dir)
			var/obj/structure/interactive/disposals/D = locate() in T.contents
			if(!D)
				continue
			world.log << "Found pipe!"
			if(D.get_connection_dir() & turn(desired_dir,180))
				. += D

	if(connects_up || connects_down)
		for(var/obj/structure/interactive/disposals/D in loc.contents)
			if(D == src)
				continue
			if( (src.connects_up && D.connects_down) || (src.connects_down && D.connects_up) )
				. += D

	return .

/obj/structure/interactive/disposals/pipe
	name = "disposals pipe"
	icon_state = "pipe"
	double_sided = TRUE
	connects_dir = TRUE

/obj/structure/interactive/disposals/clicked_on_by_object(caller,object,location,control,params)

	color = "#0000FF"

	var/list/valid_connections = get_connections()

	world.log << "Valid: [length(valid_connections)]"

	for(var/obj/structure/interactive/disposals/P in valid_connections)
		P.color = "#00FF00"
		spawn(10)
			P.color = "#FFFFFF"

	spawn(10)
		color = "#FFFFFF"

/obj/structure/interactive/disposals/pipe/ending
	name = "connector pipe"
	double_sided = FALSE
	icon_state = "pipe-t"
	connects_up = TRUE

/obj/structure/interactive/disposals/inlet
	name = "disposals inlet"
	icon_state = "intake"
	connects_down = TRUE

	collision_flags = FLAG_COLLISION_WALKING
	collision_bullet_flags = FLAG_COLLISION_BULLET_INORGANIC

	density_north = FALSE
	density_south = FALSE
	density_east  = FALSE
	density_west  = FALSE

/obj/structure/interactive/disposals/inlet/set_dir(var/desired_dir,var/force = FALSE)

	. = ..()

	if(.)
		density_north = !(dir & NORTH)
		density_east = !(dir & EAST)
		density_south = !(dir & SOUTH)
		density_west = !(dir & WEST)
		color = "#00FF00"
	else
		color = "#FF0000"

	return .

/obj/structure/interactive/disposals/inlet/Crossed(var/atom/movable/O)
	enter_pipe(O)
	return ..()

/obj/structure/interactive/disposals/outlet
	name = "disposals outlet"
	icon_state = "outlet"
	connects_down = TRUE

	collision_flags = FLAG_COLLISION_WALKING
	collision_bullet_flags = FLAG_COLLISION_BULLET_INORGANIC

	density_north = TRUE
	density_south = TRUE
	density_east  = TRUE
	density_west  = TRUE

/obj/structure/interactive/disposals/outlet/on_container_enter(var/obj/disposals_container/C)

	var/list/throw_offset = direction_to_pixel_offset(dir)

	for(var/atom/movable/M in C.contents)
		M.throw_self(src,null,null,null,throw_offset[1]*10,throw_offset[2]*10)

	qdel(C)

	return ..()