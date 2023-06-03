#define CAMERA_RECOIL_SPEED 16
#define CAMERA_PUNCH_SPEED 6

/client/proc/update_zoom(var/desired_zoom_level = 2)

	if(!mob || !eye || eye != mob)
		zoom_level = initial(zoom_level)
	else
		zoom_level = clamp(desired_zoom_level,MIN_ZOOM,MAX_ZOOM)

	winset(src, "map.map","zoom=[zoom_level]")

	return TRUE

/client/proc/spectate(var/atom/A)

	if(A == mob)
		A = null

	if(A != null && A == src.eye)
		return FALSE

	if(A == null && src.eye == mob)
		return FALSE

	src.eye = A ? A : mob

	if(src.eye == mob)
		mob.plane_master_hud?.alpha = 255
	else
		mob.plane_master_hud?.alpha = 0

/client/proc/update_view_range()

	if(settings && settings.loaded_data["view_range"])
		view = clamp(settings.loaded_data["view_range"],8,VIEW_RANGE)
	else
		view = VIEW_RANGE

	return TRUE

/client/proc/update_camera_offset(var/desired_x_offset=0,var/desired_y_offset=0)
	var/zoom_mul = 1
	if(is_advanced(mob))
		var/mob/living/advanced/A = mob
		var/obj/item/right_item = A.inventories_by_id[BODY_HAND_RIGHT_HELD]?.get_top_object()
		var/obj/item/left_item = A.inventories_by_id[BODY_HAND_LEFT_HELD]?.get_top_object()
		if(right_item && right_item.wielded && (right_item.wielded || !right_item.can_wield))
			zoom_mul = right_item.zoom_mul
			if(istype(right_item,/obj/item/weapon/ranged/))
				var/obj/item/weapon/ranged/R = right_item
				if(R.attachment_stats["zoom_mul"])
					zoom_mul *= R.attachment_stats["zoom_mul"]
		else if(left_item && left_item.wielded && (left_item.wielded || !left_item.can_wield))
			zoom_mul = left_item.zoom_mul
			if(istype(left_item,/obj/item/weapon/ranged/))
				var/obj/item/weapon/ranged/R = left_item
				if(R.attachment_stats["zoom_mul"])
					zoom_mul *= R.attachment_stats["zoom_mul"]
	zoom_pixel_x = desired_x_offset*TILE_SIZE*ZOOM_RANGE*zoom_mul
	zoom_pixel_y = desired_y_offset*TILE_SIZE*ZOOM_RANGE*zoom_mul


/client/proc/handle_camera()

	//Burger here.
	//I suspect setting the client's pixel_x and pixel_y causes lag, so they're checked.

	var/final_pixel_x = 0
	var/final_pixel_y = 0

	//For when the mob is in a projectile or something. The code below it doesn't need to run so it returns.
	if(mob && !mob.z && mob.loc)
		var/atom/A = mob.loc
		final_pixel_x = round(A.pixel_x,1)
		final_pixel_y = round(A.pixel_y,1)
		if(pixel_x != final_pixel_x)
			pixel_x = final_pixel_x
		if(pixel_y != final_pixel_y)
			pixel_y = final_pixel_y
		return TRUE

	//Camera punching. Things like explosions.
	if(queued_shakes > 0)
		final_pixel_x += rand(-TILE_SIZE*4,TILE_SIZE*4)
		final_pixel_y += rand(-TILE_SIZE*4,TILE_SIZE*4)
		queued_shakes--

	//Zooming.
	if(is_zoomed)
		final_pixel_x += zoom_pixel_x
		final_pixel_y += zoom_pixel_y

	//Do recoil
	if(recoil_pixel_x != 0)
		var/math_mod_x = recoil_pixel_x*0.5
		recoil_pixel_x -= clamp(recoil_pixel_x,-math_mod_x,math_mod_x)
		final_pixel_x += recoil_pixel_x
	if(recoil_pixel_y != 0)
		var/math_mod_y = recoil_pixel_y*0.5
		recoil_pixel_y -= clamp(recoil_pixel_y,-math_mod_y,math_mod_y)
		final_pixel_y += recoil_pixel_y

	//Done.
	final_pixel_x = final_pixel_x ? round(final_pixel_x,1) : 0
	final_pixel_y = final_pixel_y ? round(final_pixel_y,1) : 0
	if(pixel_x != final_pixel_x)
		pixel_x = final_pixel_x
	if(pixel_y != final_pixel_y)
		pixel_y = final_pixel_y

	return TRUE