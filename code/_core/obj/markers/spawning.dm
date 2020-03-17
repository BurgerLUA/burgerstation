/obj/marker/spawning/
	name = "spawning marker"

	icon = 'icons/obj/markers/spawning.dmi'

/obj/marker/spawning/New(var/desired_loc)
	do_spawn(desired_loc)
	return ..()

/obj/marker/spawning/Initialize()
	qdel(src)
	return ..()

/obj/marker/spawning/proc/do_spawn(var/turf/T)
	return TRUE




/obj/marker/spawning/window/
	icon_state = "window_grille"


/obj/marker/spawning/window/proc/setup_airlock()

	var/touching_space = src.get_best_touching_space()
	if(!touching_space)
		return FALSE

	var/obj/structure/interactive/door/alarm/D = new(src.loc)
	D.Initialize()

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

/obj/marker/spawning/window/Initialize()
	setup_airlock()
	return ..()

/obj/marker/spawning/window/do_spawn(var/turf/T)
	new/obj/structure/interactive/construction/grille(T)
	new/obj/structure/smooth/window(T)

/obj/marker/spawning/window/reinforced/
	icon_state = "window_grille_reinforced"

/obj/marker/spawning/window/reinforced/do_spawn(var/turf/T)
	new/obj/structure/interactive/construction/grille(T)
	new/obj/structure/smooth/window/reinforced(T)

/obj/marker/spawning/window/extra/
	icon_state = "window_grille_extra"

/obj/marker/spawning/window/extra/do_spawn(var/turf/T)
	new/obj/structure/interactive/construction/grille/plasteel(T)
	new/obj/structure/smooth/window/reinforced/plasma(T)

/client/verb/trigger_airlocks()
	var/alarm_count = 0
	for(var/obj/structure/interactive/door/alarm/D in world)
		D.toggle()
		alarm_count++

	src << "Found [alarm_count] airlocks."