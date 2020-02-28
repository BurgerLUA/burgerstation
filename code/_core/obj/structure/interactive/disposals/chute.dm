/obj/structure/interactive/disposals/chute
	name = "disposals chute"
	icon_state = "disposal"

	connects_down = TRUE

	collision_flags = FLAG_COLLISION_WALKING
	collision_bullet_flags = FLAG_COLLISION_BULLET_INORGANIC

	density_north = FALSE
	density_south = FALSE
	density_east  = FALSE
	density_west  = FALSE

	plane = PLANE_OBJ

/obj/structure/interactive/disposals/chute/clicked_on_by_object(var/mob/caller,object,location,control,params)

	if(is_item(object))
		var/obj/item/I = object
		I.drop_item(get_turf(src))
		enter_pipe(I)

	return ..()


/obj/structure/interactive/disposals/chute/drop_on_object(var/atom/caller,var/atom/object)

	if(ismovable(object) && caller == object)
		enter_pipe(object)
		return TRUE

	return ..()