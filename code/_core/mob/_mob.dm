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

	var/obj/inventory/left_hand
	var/obj/inventory/right_hand

	var/auto_resist = FALSE

	var/draw_inventory = TRUE

/mob/proc/toggle_inventory()
	draw_inventory = !draw_inventory
	for(var/v in inventory)
		var/obj/inventory/O = v
		if(!draw_inventory && !O.essential)
			O.invisibility = 101
		else
			O.invisibility = 0

	update_icon()

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

	if(can_walk())
		. *= 2
		on_walk()

	else if(can_sprint())
		. *= 0.5
		on_sprint()

	return .

/mob/proc/can_sprint()
	return movement_flags & MOVEMENT_RUNNING

/mob/proc/on_sprint()
	return TRUE

/mob/proc/can_walk()
	return movement_flags & MOVEMENT_WALKING

/mob/proc/on_walk()
	return TRUE

/mob/living/do_step(var/turf/new_loc, var/movement_override = 0)

	. = ..()

	var/movement_delay = get_movement_delay()

	if(left_hand)
		left_hand.do_drag(.,movement_override ? movement_override : movement_delay)

	if(right_hand)
		right_hand.do_drag(.,movement_override ? movement_override : movement_delay)

/mob/living/get_movement_delay()
	. = ..()

	if(status & FLAG_STATUS_STUN)
		. *= 4

	. = max(1, . - (. * get_skill_power(SKILL_ATHLETICS,1,100) * 0.5))

	return .

/mob/living/get_attack_delay(var/atom/victim,var/params)
	return 1 + max(0,attack_delay * (attack_delay * get_attribute_power(ATTRIBUTE_DEXTERITY,1,100) * 0.5))

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

	return TRUE