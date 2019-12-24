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

/obj/marker/spawning/window/do_spawn(var/turf/T)
	new/obj/structure/interactive/construction/grille(T)
	new/obj/structure/smooth/window(T)

/obj/marker/spawning/window/reinforced/
	icon_state = "window_grille_reinforced"

/obj/marker/spawning/window/reinforced/do_spawn(var/turf/T)
	new/obj/structure/interactive/construction/grille(T)
	new/obj/structure/smooth/window/reinforced(T)