#define CAMERA_RECOIL_SPEED 8
#define CAMERA_PUNCH_SPEED 6

/client/proc/update_zoom(var/desired_zoom_level = 2)

	if(!mob || !eye || eye != mob)
		zoom_level = initial(zoom_level)
	else
		zoom_level = clamp(desired_zoom_level,MIN_ZOOM,MAX_ZOOM)

	winset(src, "map.map","zoom=[zoom_level]")

	return TRUE

/client/MouseWheel(object,delta_x,delta_y,location,control,params)

	var/list/aug = params2list(params)

	if(mob && (mob.attack_flags & ATTACK_GRAB) && allow_zoom_controls)
		var/change_in_screen = delta_y > 1 ? 1 : -1
		if(precise_zoom)
			change_in_screen *= 0.1
		update_zoom(zoom_level + change_in_screen)
		return TRUE

	mob.do_mouse_wheel(object,delta_x,delta_y,location,control,aug)

	return TRUE

/client/proc/update_view_range()

	if(settings && settings.loaded_data["view_range"])
		view = clamp(settings.loaded_data["view_range"],4,VIEW_RANGE)
	else
		view = VIEW_RANGE

	return TRUE

/client/proc/handle_camera()

	var/zoom_offset_x = 0
	var/zoom_offset_y = 0

	if(is_zoomed)

		var/zoom_mul = 1
		if(is_advanced(mob))
			var/mob/living/advanced/A = mob
			if(A.right_item && A.right_item.wielded && (A.right_item.wielded || !A.right_item.can_wield))
				zoom_mul = A.right_item.zoom_mul
			else if(A.left_item && A.left_item.wielded && (A.left_item.wielded || !A.left_item.can_wield))
				zoom_mul = A.left_item.zoom_mul

		var/list/returning_list = direction_to_pixel_offset(is_zoomed)
		zoom_offset_x = returning_list[1]*TILE_SIZE*ZOOM_RANGE*zoom_mul
		zoom_offset_y = returning_list[2]*TILE_SIZE*ZOOM_RANGE*zoom_mul

	var/final_pixel_x = desired_recoil_x + desired_pixel_x + zoom_offset_x + desired_punch_x
	var/final_pixel_y = desired_recoil_y + desired_pixel_y + zoom_offset_y + desired_punch_y

	if(istype(mob.loc,/obj/projectile/))
		var/obj/projectile/P = mob.loc
		final_pixel_x = P.pixel_x_float
		final_pixel_y = P.pixel_y_float

	var/total_difference = abs(final_pixel_x - pixel_x) + abs(final_pixel_y - pixel_y)
	var/diff_mod = clamp(total_difference*0.1,1,10)

	var/speed = CEILING(TILE_SIZE * 0.1 * diff_mod,1)
	var/x_mod = clamp(final_pixel_x - pixel_x,-speed,speed)
	var/y_mod = clamp(final_pixel_y - pixel_y,-speed,speed)

	if(x_mod) pixel_x = pixel_x + x_mod
	if(y_mod) pixel_y = pixel_y + y_mod
	if(desired_recoil_x) desired_recoil_x -= clamp(desired_recoil_x,-CAMERA_RECOIL_SPEED,CAMERA_RECOIL_SPEED)
	if(desired_recoil_y) desired_recoil_y -= clamp(desired_recoil_y,-CAMERA_RECOIL_SPEED,CAMERA_RECOIL_SPEED)
	if(desired_punch_x) desired_punch_x -= clamp(desired_punch_x,-CAMERA_PUNCH_SPEED,CAMERA_PUNCH_SPEED)
	if(desired_punch_y) desired_punch_y -= clamp(desired_punch_y,-CAMERA_PUNCH_SPEED,CAMERA_PUNCH_SPEED)

	return TRUE