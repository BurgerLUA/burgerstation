obj/structure/lattice
	name = "support strut"
	icon = 'icons/obj/structure/lattice.dmi'
	icon_state = "lattice"

	corner_category = "lattice"
	corner_icons = TRUE

	layer = LAYER_TABLE

	collision_flags = FLAG_COLLISION_WALKING
	collision_bullet_flags = FLAG_COLLISION_BULLET_NONE

obj/structure/lattice/should_smooth_with(var/turf/T)

	. = ..()

	if(.)
		return

	if(istype(T,/turf/simulated/wall))
		return T

	var/turf/current_turf = get_turf(src)
	if(current_turf.is_space() && !T.is_space())
		return T

	return null