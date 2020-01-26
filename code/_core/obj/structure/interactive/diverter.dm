/obj/structure/interactive/diverter/
	name = "airjet diverter"
	desc = "Pssssh."
	desc_extended = "A special conveyor diverter that uses powerful jets of air to push objects off the conveyor belt based on the conditions."
	icon = 'icons/obj/structure/conveyor.dmi'
	icon_state = "diverter"

	collision_flags = FLAG_COLLISION_WALKING
	collision_bullet_flags = FLAG_COLLISION_BULLET_INORGANIC

	density_north = FALSE
	density_south = FALSE
	density_east  = FALSE
	density_west  = FALSE

/obj/structure/interactive/diverter/Initialize()

	icon_state = "diverter_on"

	if(.)
		density_north = (dir & SOUTH)
		density_east = (dir & WEST)
		density_south = (dir & NORTH)
		density_west = (dir & EAST)

	return ..()

/obj/structure/interactive/diverter/proc/should_push(var/atom/movable/M)
	return TRUE

/obj/structure/interactive/diverter/Crossed(var/atom/movable/M,var/atom/NewLoc,var/atom/OldLoc)

	if(!M.anchored && !M.grabbing_hand && should_push(M))
		M.Move(get_step(src,dir),silent = TRUE)

	return ..()


/obj/structure/interactive/diverter/high_value
	name = "airjet diverter (high value)"
	desc_extended = "A special conveyor diverter that uses powerful jets of air to push objects off the conveyor belt based on the conditions. This one scans the value of the object and pushes it if it exceeds a certain amount."
	var/value_threshold = 50

/obj/structure/interactive/diverter/high_value/should_push(var/atom/movable/M)
	if(is_item(M))
		var/obj/item/I = M
		return I.value >= value_threshold

	return FALSE


/obj/structure/interactive/diverter/density
	name = "airjet diverter (density)"
	desc_extended = "A special conveyor diverter that uses powerful jets of air to push objects off the conveyor belt based on the conditions. This one measures the density of the object."

/obj/structure/interactive/diverter/density/should_push(var/atom/movable/M)
	return M.collision_flags != FLAG_COLLISION_NONE