/obj/structure/interactive/disposals/pipe
	name = "disposals pipe"
	icon_state = "pipe"
	layer = LAYER_FLOOR_PIPE
	under_tile = TRUE

/obj/structure/interactive/disposals/pipe/get_connections()

	. = list()

	if(dir == NORTH || dir == EAST || dir == SOUTH || dir == WEST)
		.["[dir]"] = TRUE
		.["[turn(dir,180)]"] = TRUE
	else
		for(var/c_dir in DIRECTIONS_CARDINAL)
			if(!(dir & c_dir))
				continue
			.["[c_dir]"] = TRUE


	return .

/obj/structure/interactive/disposals/pipe/Finalize()

	var/disposals_count = 0
	for(var/obj/structure/interactive/disposals/pipe/DP in src.loc.contents)
		disposals_count++


	if(disposals_count > 1)
		log_error("Multiple disposals pipes ([disposals_count]) detected at [src.loc.get_debug_name()].")

	return ..()



/obj/structure/interactive/disposals/pipe/New(var/desired_loc)
	plane = PLANE_FLOOR
	return ..()

/obj/structure/interactive/disposals/pipe/ending
	name = "connector disposals pipe"
	icon_state = "pipe-t"

/obj/structure/interactive/disposals/pipe/ending/get_connections()
	. = list()
	.["[dir]"] = TRUE
	.["0"] = TRUE
	return .

/obj/structure/interactive/disposals/pipe/junction
	name = "junction disposals pipe"
	icon_state = "pipe-j1"

/obj/structure/interactive/disposals/pipe/junction/get_connections()
	. = list()
	.["[dir]"] = TRUE
	.["[turn(dir,180)]"] = FALSE
	.["[turn(dir,-90)]"] = FALSE
	return .

/obj/structure/interactive/disposals/pipe/junction/flipped
	icon_state = "pipe-j2"

/obj/structure/interactive/disposals/pipe/junction/flipped/get_connections()
	. = list()
	.["[dir]"] = TRUE
	.["[turn(dir,180)]"] = FALSE
	.["[turn(dir,90)]"] = FALSE
	return .

/obj/structure/interactive/disposals/pipe/junction/sorting
	name = "junction sorting disposals pipe"
	icon_state = "pipe-j1s"

/obj/structure/interactive/disposals/pipe/junction/sorting/get_connections()
	. = list()
	.["[dir]"] = TRUE
	.["[turn(dir,180)]"] = FALSE
	.["[turn(dir,-90)]"] = sorting_tag
	return .


/obj/structure/interactive/disposals/pipe/junction/sorting/flipped
	name = "junction sorting disposals pipe"
	icon_state = "pipe-j2s"

/obj/structure/interactive/disposals/pipe/junction/sorting/flipped/get_connections()
	. = list()
	.["[dir]"] = TRUE
	.["[turn(dir,180)]"] = FALSE
	.["[turn(dir,90)]"] = sorting_tag
	return .

/obj/structure/interactive/disposals/pipe/x
	name = "4-way junction disposals pipe"
	icon_state = "pipe-4way"

/obj/structure/interactive/disposals/pipe/x/get_connections()
	. = list()
	for(var/d in DIRECTIONS_CARDINAL)
		.["[d]"] = d == dir
	return .