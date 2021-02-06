/obj/structure/interactive/barricade
	name = "metal barricade"
	desc_extended = "Has a 90% chance to block most types of projectiles when a bullet passes it from the outside."
	icon = 'icons/obj/structure/barricade.dmi'
	icon_state = "metal"

	plane = PLANE_MOB
	collision_flags = FLAG_COLLISION_BARICADE
	collision_bullet_flags = FLAG_COLLISION_BULLET_INORGANIC
	density = TRUE

	collision_dir = 0x0

	bullet_block_chance = 90

	health = /health/construction/barricade

	flags_placement = FLAGS_PLACEMENT_DIRECTIONAL

	health_base = 600

	var/list/climbers = list()

	repair_flag = FLAG_TOOL_WELDER

/obj/structure/interactive/barricade/Cross(atom/movable/O)
	if(climbers[O])
		return TRUE
	return ..()

/obj/structure/interactive/barricade/Uncross(atom/movable/O)
	if(climbers[O])
		return TRUE
	return ..()

/obj/structure/interactive/barricade/proc/can_climb_over(var/mob/caller)

	INTERACT_CHECK_NO_DELAY(src)

	if(!is_living(caller))
		return FALSE

	var/mob/living/L = caller

	if(L.horizontal)
		caller.to_chat(span("warning","You need to be standing in order to climb over \the [src.name]!"))
		return FALSE

	return TRUE

/obj/structure/interactive/barricade/proc/climb_over(var/mob/caller)

	climbers[caller] = TRUE

	if(caller.loc == src.loc)
		caller.Move(get_step(src,src.dir))
	else
		caller.Move(src.loc)

	climbers -= caller

	return TRUE


/obj/structure/interactive/barricade/clicked_on_by_object(var/mob/caller,var/atom/object,location,control,params)



	if(is_advanced(caller) && is_inventory(object) && can_climb_over(caller))
		INTERACT_CHECK
		INTERACT_CHECK_OBJECT
		INTERACT_DELAY(5)
		PROGRESS_BAR(caller,src,SECONDS_TO_DECISECONDS(2),.proc/climb_over,caller)
		PROGRESS_BAR_CONDITIONS(caller,src,.proc/can_climb_over,caller)
		caller.visible_message(span("warning","\The [caller.name] begins climbing over \the [src.name]."),span("notice","You begin climbing over \the [src.name]."))
		return TRUE

	return ..()

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