/turf/simulated/bluespace
	name = "bluespace"
	icon_state = "bluespace"

	density_north = TRUE
	density_east = TRUE
	density_south = TRUE
	density_west = TRUE
	density_up = TRUE
	density_down = TRUE

	collision_flags = FLAG_COLLISION_WALL
	collision_bullet_flags = FLAG_COLLISION_BULLET_INORGANIC

/turf/simulated/bluespace/is_space()
	return TRUE


/turf/simulated/bluespace/Crossed(var/atom/movable/O,var/atom/new_loc,var/atom/old_loc)

	. = ..()

	if(. && !istype(O,/mob/abstract/))
		O.visible_message(span("danger","\The [O.name] flashes violently!"))
		if(is_safe_to_delete(O))
			qdel(O)
		else
			O.force_move(pick(rift_markers))

