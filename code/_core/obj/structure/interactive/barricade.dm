/obj/structure/interactive/barricade
	name = "metal barricade"
	desc_extended = "Has a 90% chance to block most types of projectiles when a bullet passes it from the outside."
	icon = 'icons/obj/structure/barricade.dmi'
	icon_state = "metal"

	plane = PLANE_MOVABLE
	collision_flags = FLAG_COLLISION_BARICADE
	collision_bullet_flags = FLAG_COLLISION_BULLET_INORGANIC
	density = TRUE

	collision_dir = 0x0

	bullet_block_chance = 90

	health = /health/construction/barricade

	flags_placement = FLAG_PLACEMENT_DIRECTIONAL

	health_base = 800

	var/list/climbers = list()

	repair_flag = FLAG_TOOL_WELDER

/obj/structure/interactive/barricade/Initialize()
	. = ..()
	set_dir(dir,TRUE)

/obj/structure/interactive/barricade/Destroy()
	. = ..()
	climbers.Cut()

/obj/structure/interactive/barricade/Cross(atom/movable/O,atom/oldloc)
	if(climbers[O])
		return TRUE
	return ..()

/obj/structure/interactive/barricade/Uncross(atom/movable/O,atom/newloc)
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
		PROGRESS_BAR(caller,src,SECONDS_TO_DECISECONDS(2),src::climb_over(),caller)
		PROGRESS_BAR_CONDITIONS(caller,src,src::can_climb_over(),caller)
		caller.visible_message(span("warning","\The [caller.name] begins climbing over \the [src.name]."),span("notice","You begin climbing over \the [src.name]."))
		return TRUE

	return ..()

obj/structure/interactive/barricade/Finalize()
	. = ..()
	update_sprite()

/obj/structure/interactive/barricade/set_dir(var/desired_dir,var/force=FALSE)

	. = ..()

	if(.)
		pixel_x = 0
		pixel_y = 0
		update_collisions(c_dir = dir)


/obj/structure/interactive/barricade/update_overlays()

	. = ..()

	var/image/above = new/image(icon,"[icon_state]_above")
	above.layer = LAYER_MOB_ABOVE
	above.appearance_flags = src.appearance_flags | KEEP_APART

	var/image/below = new/image(icon,"[icon_state]_below")
	below.layer = LAYER_MOB_BELOW
	below.appearance_flags = src.appearance_flags | KEEP_APART

	icon = ICON_INVISIBLE
	add_overlay(below)
	add_overlay(above)



/obj/structure/interactive/barricade/on_destruction(var/damage = TRUE)
	create_destruction(get_turf(src),list(/obj/item/material/sheet/ = 2),/material/steel)
	. = ..()
	qdel(src)
