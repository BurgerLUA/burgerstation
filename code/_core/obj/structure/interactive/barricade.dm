/obj/structure/interactive/barricade
	name = "metal barricade"
	desc_extended = "Has a 60% chance to block most types of projectiles when a bullet passes it from the outside."
	icon = 'icons/obj/structure/barricade.dmi'
	icon_state = "metal"

	plane = PLANE_MOB
	collision_flags = FLAG_COLLISION_BARICADE
	collision_bullet_flags = FLAG_COLLISION_BULLET_INORGANIC

	collision_dir = 0x0

	bullet_block_chance = 90

	health = /health/construction/

	flags_placement = FLAGS_PLACEMENT_DIRECTIONAL

	health_base = 300

obj/structure/interactive/barricade/PostInitialize()
	. = ..()
	update_sprite()
	return .

/obj/structure/interactive/barricade/update_sprite()

	. = ..()

	var/desired_dense = 0x0

	if(dir == NORTH)
		pixel_x = 0
		pixel_y = 0
		desired_dense |= NORTH
	else if(dir == EAST)
		pixel_x = 0
		pixel_y = 0
		desired_dense |= EAST
	else if(dir == SOUTH)
		pixel_x = 0
		pixel_y = 0
		desired_dense |= SOUTH
	else if(dir == WEST)
		pixel_x = 0
		pixel_y = 0
		desired_dense |= WEST

	update_collisions(c_dir = desired_dense)

	return .

/obj/structure/interactive/barricade/update_overlays()

	. = ..()

	var/image/above = new/image(icon,"[icon_state]_above")
	above.layer = LAYER_MOB_ABOVE

	var/image/below = new/image(icon,"[icon_state]_below")
	below.layer = LAYER_MOB_BELOW

	icon = ICON_INVISIBLE
	add_overlay(below)
	add_overlay(above)

	return .


/obj/structure/interactive/barricade/on_destruction(var/mob/caller,var/damage = FALSE)
	create_destruction(get_turf(src),list(/obj/item/material/sheet/ = 2),/material/steel)
	. = ..()
	qdel(src)
	return .