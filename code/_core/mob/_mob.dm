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
	var/list/obj/button/buttons //List of HUD buttons

	var/list/datum/animation/animations //List of running animation
	var/animation_pixel_x = 0
	var/animation_pixel_y = 0

	var/list/experience/attribute/attributes
	var/list/experience/skill/skills

	animate_movement = FALSE

	movement_delay = 4

	attack_delay = 4

/mob/New()
	inventory = list()
	attributes = list()
	skills = list()
	buttons = list()

	all_mobs += src
	..()

/mob/Initialize()
	initialize_attributes()
	initialize_skills()
	. = ..()

/mob/proc/initialize_attributes()
	for(var/v in all_attributes)
		var/experience/attribute/A = new v(src)
		A.experience = A.level_to_xp(ATTRIBUTE_DEFAULT)
		attributes[A.name] = A

/mob/proc/initialize_skills()
	for(var/v in all_skills)
		var/experience/skill/S = new v(src)
		S.experience = S.level_to_xp(SKILL_DEFAULT)
		skills[S.name] = S

/mob/proc/on_life_client()
	handle_movement(TRUE)
	return TRUE

/mob/proc/on_life()
	return TRUE

/mob/get_movement_delay()

	var/delay = 1 + max(0,movement_delay * (1 - get_attribute_power(ATTRIBUTE_AGILITY,1,100)))

	if(movement_flags & MOVEMENT_CROUCHING)
		delay *= 2

	/*
	if(movement_flags & MOVEMENT_WALKING)
		delay *= 2
	*/

	if(movement_flags & MOVEMENT_RUNNING)
		delay *= 0.5

	return delay

/mob/get_attack_delay(var/atom/victim,var/params)
	return 1 + max(0,attack_delay * (1 - get_attribute_power(ATTRIBUTE_AGILITY,1,100)))

/mob/do_movement_effects(var/turf/old_loc, var/turf/new_loc, var/movement_override = 0)
	var/pixel_x_offset = -(new_loc.x - old_loc.x)*step_size
	var/pixel_y_offset = -(new_loc.y - old_loc.y)*step_size

	var/real_movement_delay = movement_override ? movement_override : get_movement_delay()
	var/movement_dir = old_loc.get_relative_dir(new_loc)

	if(client) //Animate the client's camera so it's smooth.
		animate(client, pixel_x = client.pixel_x + pixel_x_offset, pixel_y = client.pixel_y + pixel_y_offset, time = 1, flags = ANIMATION_LINEAR_TRANSFORM)
		animate(client, pixel_x = client.pixel_x - pixel_x_offset, pixel_y = client.pixel_y - pixel_y_offset, time = real_movement_delay, flags = ANIMATION_LINEAR_TRANSFORM)

	animate(src, pixel_x = src.pixel_x + pixel_x_offset, pixel_y = src.pixel_y + pixel_y_offset, time = 1, flags = ANIMATION_LINEAR_TRANSFORM)
	animate(src, pixel_x = src.pixel_x - pixel_x_offset, pixel_y = src.pixel_y - pixel_y_offset, time = real_movement_delay, flags = ANIMATION_LINEAR_TRANSFORM, dir = movement_dir)

	return ..()

/mob/do_bump(var/atom/bumper, var/bump_direction = 0, var/movement_override = 0)
	if(move_delay > 0)
		return FALSE
	return do_move(get_step(src,bump_direction),movement_override)

/mob/can_not_enter(var/atom/A,var/move_direction)
	if(is_mob(A))
		return src
	return FALSE

/mob/proc/has_beast_legs()
	return FALSE