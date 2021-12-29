/obj/marker/spawning/
	name = "spawning marker"
	icon = 'icons/obj/markers/spawning.dmi'
	initialize_type = INITIALIZE_EARLY
	plane = PLANE_OBJ

/obj/marker/spawning/Initialize()
	do_spawn(src.loc)
	. = ..()
	qdel(src)

/obj/marker/spawning/proc/do_spawn(var/turf/T)
	return TRUE

/obj/marker/spawning/window/
	name = "full window"
	icon_state = "window_grille"

/obj/marker/spawning/window/proc/setup_airlock()

	var/turf/simulated/T = src.loc
	if(istype(T))
		T.map_color = "#222222"

	var/touching_space = src.get_best_touching_space()
	if(!touching_space)
		return FALSE

	var/obj/structure/interactive/door/alarm/D = new(src.loc)
	LATE_INIT(D)

	//This forces it to be one of 4 directions.
	if(touching_space & NORTH)
		D.set_dir(NORTH)
	else if(touching_space & SOUTH)
		D.set_dir(SOUTH)
	else if(touching_space & EAST)
		D.set_dir(EAST)
	else if(touching_space & WEST)
		D.set_dir(WEST)

	return D

/obj/marker/spawning/window/do_spawn(var/turf/T)
	var/obj/structure/interactive/construction/grille/G = new(T)
	var/obj/structure/smooth/window/W = new(T)
	LATE_INIT(G)
	LATE_INIT(W)
	setup_airlock()

/obj/marker/spawning/window/tinted/do_spawn(var/turf/T)
	var/obj/structure/interactive/construction/grille/G = new(T)
	var/obj/structure/smooth/window/W = new(T)
	LATE_INIT(G)
	LATE_INIT(W)
	W.color = "#353535"
	W.opacity = 0
	setup_airlock()

/obj/marker/spawning/window/rcd/do_spawn(var/turf/T)
	var/obj/structure/interactive/construction/grille/G = new(T)
	var/obj/structure/smooth/window/W = new(T)
	INITIALIZE(G)
	INITIALIZE(W)
	GENERATE(G)
	GENERATE(W)
	FINALIZE(G)
	FINALIZE(W)
	queue_update_smooth_edges(W)

/obj/marker/spawning/window/reinforced/
	icon_state = "window_grille_reinforced"

/obj/marker/spawning/window/reinforced/do_spawn(var/turf/T)
	var/obj/structure/interactive/construction/grille/G = new(T)
	var/obj/structure/smooth/window/reinforced/W = new(T)
	LATE_INIT(G)
	LATE_INIT(W)
	setup_airlock()

/obj/marker/spawning/window/extra/
	icon_state = "window_grille_extra"

/obj/marker/spawning/window/extra/do_spawn(var/turf/T)
	var/obj/structure/interactive/construction/grille/plasteel/G = new(T)
	var/obj/structure/smooth/window/reinforced/plasma/W = new(T)
	LATE_INIT(G)
	LATE_INIT(W)
	setup_airlock()

/obj/marker/spawning/random
	var/list/possible_objects = list()
	var/chance_none = 0


/obj/marker/spawning/random/do_spawn(var/turf/T)
	if(!prob(chance_none))
		var/atom/movable/M = pickweight(possible_objects)
		M = new M(T)
		LATE_INIT(M)

/obj/marker/spawning/random/object_of_interest
	possible_objects = list(
		/obj/structure/interactive/vending/random = 1,
		/obj/structure/interactive/vending/old_ammo = 1,
		/obj/item/storage/heavy/trash_pile = 1
	)

/obj/marker/spawning/random/supply_crate
	name = "random supply crate"
	icon_state = "supply"
	possible_objects = list(
		/obj/item/supply_crate/american = 1,
		/obj/item/supply_crate/magic = 2,
		/obj/item/supply_crate/nanotrasen = 3,
		/obj/item/supply_crate/russian = 2,
		/obj/item/supply_crate/syndicate = 2,
		/obj/item/supply_crate/medicine = 20
	)
	chance_none = 75