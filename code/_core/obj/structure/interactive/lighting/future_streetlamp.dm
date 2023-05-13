/obj/structure/interactive/lighting/roadlamp
	name = "street lamp"

	icon = 'icons/obj/structure/streetlamp.dmi'
	icon_state = "lamp"

	desired_light_power = 0.75
	desired_light_range = VIEW_RANGE*0.25
	desired_light_color = "#FFFF78"

	layer = LAYER_MOB_ABOVE

	plane = PLANE_MOVABLE

	collision_flags = FLAG_COLLISION_WALL
	collision_bullet_flags = FLAG_COLLISION_BULLET_INORGANIC
	collision_dir = NORTH | EAST | SOUTH | WEST

	//density = TRUE

/obj/structure/interactive/lighting/roadlamp/Finalize()
	. = ..()
	update_sprite()

/obj/structure/interactive/lighting/roadlamp/update_sprite()

	. = ..()

	var/desired_dense = 0x0

	if(dir == NORTH)
		pixel_x = 0
		pixel_y = 1
		desired_dense |= SOUTH
		plane = PLANE_SCENERY
		light_offset_y = TILE_SIZE
	else if(dir == EAST)
		pixel_x = 1
		pixel_y = 0
		desired_dense |= WEST
		plane = PLANE_SCENERY
		light_offset_x = TILE_SIZE
	else if(dir == SOUTH)
		pixel_x = 0
		pixel_y = 23
		desired_dense |= NORTH
		light_offset_y = -TILE_SIZE
	else if(dir == WEST)
		pixel_x = -1
		pixel_y = 0
		desired_dense |= EAST
		plane = PLANE_SCENERY
		light_offset_x = -TILE_SIZE

	update_collisions(c_dir = desired_dense)