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

	var/list/datum/animation/animations //List of running animation
	var/animation_pixel_x = 0
	var/animation_pixel_y = 0

	animate_movement = FALSE

	movement_delay = 4

	attack_delay = 2

/mob/proc/add_inventory(var/obj/inventory/I)
	inventory += I
	if(client)
		client.screen += I
	update_inventory()

/mob/proc/remove_inventory(var/obj/inventory/I)
	inventory -= I
	if(client)
		client.screen -= I
	update_inventory()

/mob/proc/update_inventory()
	if(client)
		client.known_inventory = inventory

/mob/New()
	all_mobs += src
	//animations = list()
	inventory = list()
	. = ..()

/mob/proc/on_life_client()
	handle_movement(TRUE)
	return TRUE

/mob/proc/on_life()
	return TRUE

/mob/get_movement_delay()

	var/delay = movement_delay

	if(movement_flags & MOVEMENT_CROUCHING)
		delay *= 2

	/*
	if(movement_flags & MOVEMENT_WALKING)
		delay *= 2
	*/

	if(movement_flags & MOVEMENT_RUNNING)
		delay *= 0.5

	return delay

/mob/do_movement_effects(var/turf/old_loc,var/turf/new_loc)
	var/pixel_x_offset = -(new_loc.x - old_loc.x)*step_size
	var/pixel_y_offset = -(new_loc.y - old_loc.y)*step_size

	var/real_movement_delay = get_movement_delay()
	var/movement_dir = old_loc.get_relative_dir(new_loc)

	if(client) //Animate the client's camera so it's smooth.
		animate(client, pixel_x = client.pixel_x + pixel_x_offset, pixel_y = client.pixel_y + pixel_y_offset, time = 1, flags = ANIMATION_LINEAR_TRANSFORM)
		animate(client, pixel_x = client.pixel_x - pixel_x_offset, pixel_y = client.pixel_y - pixel_y_offset, time = real_movement_delay, flags = ANIMATION_LINEAR_TRANSFORM)

	animate(src, pixel_x = src.pixel_x + pixel_x_offset, pixel_y = src.pixel_y + pixel_y_offset, time = 1, flags = ANIMATION_LINEAR_TRANSFORM)
	animate(src, pixel_x = src.pixel_x - pixel_x_offset, pixel_y = src.pixel_y - pixel_y_offset, time = real_movement_delay, flags = ANIMATION_LINEAR_TRANSFORM, dir = movement_dir)

	return ..()

/mob/do_bump(var/atom/bumper,var/bump_direction)
	if(move_delay > 0)
		return FALSE
	return do_move(get_step(src,bump_direction))

/mob/can_not_enter(var/atom/A,var/move_direction)
	if(is_mob(A))
		return src
	return FALSE
