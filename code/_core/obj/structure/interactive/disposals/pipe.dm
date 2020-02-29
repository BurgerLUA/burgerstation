/obj/structure/interactive/disposals/pipe
	name = "disposals pipe"
	icon_state = "pipe"
	double_sided = TRUE
	connects_dir = TRUE
	/*
	layer = LAYER_GROUND_SCENERY
	under_tile = TRUE
	*/

/obj/structure/interactive/disposals/pipe/New(var/desired_loc)
	//plane = PLANE_FLOOR_OBJECTS
	return ..()

/obj/structure/interactive/disposals/pipe/ending
	name = "connector disposals pipe"
	double_sided = FALSE
	icon_state = "pipe-t"
	connects_up = TRUE

/obj/structure/interactive/disposals/pipe/junction
	name = "junction disposals pipe"
	icon_state = "pipe-j1"
	junction_angle = 90

/obj/structure/interactive/disposals/pipe/junction/flipped
	icon_state = "pipe-j2"
	junction_angle = -90

/obj/structure/interactive/disposals/pipe/junction/sorting
	name = "junction sorting disposals pipe"
	icon_state = "pipe-j1s"
	junction_angle = 90

/obj/structure/interactive/disposals/pipe/junction/sorting/flipped
	name = "junction sorting disposals pipe"
	icon_state = "pipe-j2s"
	junction_angle = -90

/obj/structure/interactive/disposals/pipe/x
	name = "4-way junction disposals pipe"
	icon_state = "pipe-4way"

/obj/structure/interactive/disposals/pipe/x/get_connection_dir()
	return DIRECTIONS_CARDINAL

/obj/structure/interactive/disposals/pipe/x/get_connections(var/src_connection_dir = get_connection_dir())

	. = list()

	var/turf/T = get_step(src,dir)
	var/obj/structure/interactive/disposals/D = locate() in T.contents
	if(D && (D.get_connection_dir() & turn(dir,180)) )
		.[D] = TRUE

	return