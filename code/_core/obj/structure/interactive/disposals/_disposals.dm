/obj/structure/interactive/disposals/
	icon = 'icons/obj/structure/disposals.dmi'
	var/obj/disposals_container/disposals_container
	var/list/obj/structure/interactive/disposals/connected_pipes

	//Connection Info
	var/double_sided = FALSE
	var/connects_dir = FALSE
	var/connects_up = FALSE
	var/connects_down = FALSE
	var/junction_angle = 0
	var/sorting_tag = null //Give it a sorting tag if this is also a junction.
	var/sorting_tab_label = null //If this goes into the pipe, give it a label if any.

	anchored = TRUE


/obj/structure/interactive/disposals/update_icon()
	name = "[initial(name)] ([sorting_tab_label])"
	return ..()

/obj/structure/interactive/disposals/proc/on_container_enter(var/obj/disposals_container/C)

	if(sorting_tab_label && sorting_tab_label != "none")
		C.sorting_tag = sorting_tab_label

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
	M.glide_size = M.step_size / DECISECONDS_TO_TICKS(1)
	return TRUE

/obj/structure/interactive/disposals/proc/get_connection_dir()

	if(!connects_dir)
		return 0x0

	var/src_connections = 0x0

	if(double_sided && (src.dir in DIRECTIONS_CARDINAL))
		src_connections = src.dir | turn(src.dir,180)
	else
		src_connections = src.dir

	return src_connections

/obj/structure/interactive/disposals/proc/get_connections(var/src_connection_dir = get_connection_dir())

	. = list()

	if(junction_angle)
		var/turf/T = get_step(src,dir)
		var/obj/structure/interactive/disposals/D = locate() in T.contents
		if(D && (D.get_connection_dir() & turn(dir,180)) )
			.[D] = sorting_tag ? sorting_tag : "none"

	if(connects_dir)
		for(var/desired_dir in DIRECTIONS_CARDINAL)
			if(!(src_connection_dir & desired_dir))
				continue
			var/turf/T = get_step(src,desired_dir)
			for(var/obj/structure/interactive/disposals/D in T.contents)
				if(D.get_connection_dir() & turn(desired_dir,180))
					.[D] = TRUE
				else if(D.junction_angle && src_connection_dir & turn(D.dir,-D.junction_angle))
					.[D] = TRUE

	if(connects_up || connects_down)
		for(var/obj/structure/interactive/disposals/D in loc.contents)
			if(D == src)
				continue
			if( (src.connects_up && D.connects_down) || (src.connects_down && D.connects_up) )
				.[D] = TRUE

	return .

/obj/structure/interactive/disposals/clicked_on_by_object(caller,object,location,control,params)

	color = "#0000FF"

	for(var/obj/structure/interactive/disposals/D in get_connections())
		D.color = "#00FF00"
		spawn(10)
			D.color = "#FFFFFF"

	spawn(10)
		color = "#FFFFFF"

	return ..()