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


/turf/simulated/bluespace/Entered(atom/movable/Obj, atom/OldLoc)

	. = ..()

	if(. && !istype(Obj,/mob/abstract/))
		Obj.visible_message(span("danger","\The [Obj.name] flashes violently!"))
		Obj.force_move(pick(rift_markers))

