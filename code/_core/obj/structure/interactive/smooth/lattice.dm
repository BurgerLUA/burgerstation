obj/structure/smooth/lattice
	name = "support strut"
	icon = 'icons/obj/structure/smooth/lattice.dmi'
	icon_state = "lattice"

	corner_category = "lattice"
	corner_icons = TRUE

	layer = LAYER_TABLE

	collision_flags = FLAG_COLLISION_WALKING
	collision_bullet_flags = FLAG_COLLISION_BULLET_NONE

obj/structure/smooth/lattice/should_smooth_with(var/turf/T)

	. = ..()

	if(.)
		return .

	if(istype(T,/turf/simulated/wall/))
		return TRUE

	if(istype(src.loc,/turf/simulated/floor/space) && !istype(T,/turf/simulated/floor/space))
		return TRUE

	return FALSE