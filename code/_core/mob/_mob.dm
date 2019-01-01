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
	client.known_inventory = inventory

/mob/New()
	all_mobs += src
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

/*
/mob/Destroy() //TODO: Destroy system
	all_mobs -= src
*/


/mob/Move(NewLoc,Dir=0,step_x=0,step_y=0)

	if((Dir & WEST) && (Dir & EAST))
		return FALSE

	if((Dir & NORTH) && (Dir & SOUTH))
		return FALSE

	if(..())
		var/pixel_x_offset = 0
		var/pixel_y_offset = 0

		if(Dir & NORTH)
			pixel_y_offset = -step_size

		if(Dir & SOUTH)
			pixel_y_offset = step_size

		if(Dir & EAST)
			pixel_x_offset = -step_size

		if(Dir & WEST)
			pixel_x_offset = step_size

		var/movement_delay = get_movement_delay()
		if(client)
			animate(client, LINEAR_EASING, time = 1, pixel_x = pixel_x_offset, pixel_y = pixel_y_offset, flags = ANIMATION_LINEAR_TRANSFORM)
			animate(client, LINEAR_EASING, time = movement_delay * 1, pixel_x = 0, pixel_y = 0, flags = ANIMATION_LINEAR_TRANSFORM)

		animate(src, LINEAR_EASING, time = 1, pixel_x = pixel_x_offset, pixel_y = pixel_y_offset, flags = ANIMATION_LINEAR_TRANSFORM)
		animate(src, LINEAR_EASING, time = movement_delay * 1, pixel_x = 0, pixel_y = 0, flags = ANIMATION_LINEAR_TRANSFORM)