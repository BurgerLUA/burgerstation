var/global/list/all_mobs = list()

/mob/
	name = "MOB ERROR"
	icon = 'icons/debug/mobs.dmi'
	icon_state = ""
	layer = LAYER_MOB
	var/enable_AI = FALSE

	var/tmp/movement_flags = 0x0

	var/tmp/attack_flags = 0x0

	var/list/obj/inventory/inventory //List of inventory items
	var/list/obj/item/worn_objects //List of worn items. For use in an easy read-only list.

	var/list/obj/button/buttons //List of HUD buttons

	var/list/datum/animation/animations //List of running animation
	var/animation_pixel_x = 0
	var/animation_pixel_y = 0

	animate_movement = FALSE

	movement_delay = 4

	attack_delay = 4

/mob/Initialize()
	for(var/obj/structure/interactive/localmachine/L in local_machines)
		L.update_for_mob(src)
	..()



/mob/New(var/loc/spawning_location,var/client/C)

	if(C)
		client = C
		ckey = C.ckey

	inventory = list()
	buttons = list()
	worn_objects = list()

	all_mobs += src
	..()

/mob/proc/on_life_client()
	handle_movement(TRUE)
	return TRUE

/mob/proc/on_life()
	return TRUE

/mob/get_movement_delay()

	. = ..()

	if(movement_flags & MOVEMENT_WALKING)
		. *= 2

	if(movement_flags & MOVEMENT_RUNNING)
		. *= 0.5

	return .

/mob/living/get_movement_delay()
	. = ..()
	return max(1, . * (1 - get_attribute_power(ATTRIBUTE_AGILITY,1,100)))


/mob/living/get_attack_delay(var/atom/victim,var/params)
	return 1 + max(0,attack_delay * (1 - get_attribute_power(ATTRIBUTE_AGILITY,1,100)))

/mob/do_movement_effects(var/turf/old_loc, var/turf/new_loc, var/movement_override = 0)
	var/pixel_x_offset = -(new_loc.x - old_loc.x)*step_size
	var/pixel_y_offset = -(new_loc.y - old_loc.y)*step_size

	var/real_movement_delay = movement_override ? movement_override : get_movement_delay()
	var/movement_dir = old_loc.get_relative_dir(new_loc)

	if(client && client.eye == src) //Animate the client's camera so it's smooth.
		animate(client, pixel_x = client.pixel_x + pixel_x_offset, pixel_y = client.pixel_y + pixel_y_offset, time = 1, flags = ANIMATION_LINEAR_TRANSFORM)
		animate(client, pixel_x = client.pixel_x - pixel_x_offset, pixel_y = client.pixel_y - pixel_y_offset, time = real_movement_delay, flags = ANIMATION_LINEAR_TRANSFORM)

	animate(src, pixel_x = src.pixel_x + pixel_x_offset, pixel_y = src.pixel_y + pixel_y_offset, time = 1, flags = ANIMATION_LINEAR_TRANSFORM)
	animate(src, pixel_x = src.pixel_x - pixel_x_offset, pixel_y = src.pixel_y - pixel_y_offset, time = real_movement_delay, flags = ANIMATION_LINEAR_TRANSFORM, dir = movement_dir)

	return ..()

/mob/living/do_bump(var/atom/bumper, var/bump_direction = 0, var/movement_override = 0)
	if(move_delay > 0)
		return FALSE
	return do_move(get_step(src,bump_direction),movement_override)

/mob/living/can_not_enter(var/atom/A,var/move_direction)
	if(is_living(A))
		return src
	return FALSE