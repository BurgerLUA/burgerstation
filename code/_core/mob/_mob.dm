/mob/
	name = "MOB ERROR"
	icon = 'icons/debug/mobs.dmi'
	icon_state = ""
	layer = LAYER_MOB
	var/enable_AI = FALSE

	var/tmp/movement_flags = 0x0
	var/tmp/attack_flags = 0x0

	var/list/obj/button/buttons //List of HUD buttons

	var/animation_pixel_x = 0
	var/animation_pixel_y = 0
	animate_movement = FALSE

	movement_delay = 4
	attack_delay = 10

	var/attack_turn = 0
	var/attack_turn_delay = 10

	var/auto_resist = FALSE

	mouse_opacity = 0

/mob/Initialize()
	for(var/obj/structure/interactive/localmachine/L in local_machines)
		L.update_for_mob(src)
	..()

/mob/New(var/loc/spawning_location,var/client/C)
	if(C)
		client = C
		ckey = C.ckey
		C.reset()

	buttons = list()

	all_mobs += src
	..()

/mob/do_movement_effects(var/turf/old_loc, var/turf/new_loc, var/movement_override = 0)

	var/pixel_x_offset = -(new_loc.x - old_loc.x)*step_size
	var/pixel_y_offset = -(new_loc.y - old_loc.y)*step_size

	var/real_movement_delay = movement_override ? movement_override : get_movement_delay()
	var/movement_dir = old_loc.get_relative_dir(new_loc)

	if(client && client.eye == src) //Animate the client's camera so it's smooth.
		animate(client, pixel_x = client.pixel_x + pixel_x_offset, pixel_y = client.pixel_y + pixel_y_offset, time = 1, flags = ANIMATION_LINEAR_TRANSFORM)
		animate(client, pixel_x = client.pixel_x - pixel_x_offset, pixel_y = client.pixel_y - pixel_y_offset, time = real_movement_delay, flags = ANIMATION_LINEAR_TRANSFORM)

	animate(src, pixel_x = src.pixel_x + pixel_x_offset, pixel_y = src.pixel_y + pixel_y_offset, time = 1, flags = ANIMATION_LINEAR_TRANSFORM)
	animate(src, pixel_x = src.pixel_x - pixel_x_offset, pixel_y = src.pixel_y - pixel_y_offset, time = real_movement_delay, flags = ANIMATION_LINEAR_TRANSFORM)

	if(attack_turn <= curtime)
		dir = movement_dir

	return TRUE