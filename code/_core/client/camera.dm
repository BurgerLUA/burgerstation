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
		if(A.right_item && A.right_item.wielded && (A.right_item.wielded || !A.right_item.can_wield))
			zoom_mul = A.right_item.zoom_mul
			if(istype(A.right_item,/obj/item/weapon/ranged/))
				var/obj/item/weapon/ranged/R = A.right_item
				if(R.attachment_stats["zoom_mul"])
					zoom_mul *= R.attachment_stats["zoom_mul"]
		else if(A.left_item && A.left_item.wielded && (A.left_item.wielded || !A.left_item.can_wield))
			zoom_mul = A.left_item.zoom_mul
			if(istype(A.left_item,/obj/item/weapon/ranged/))
				var/obj/item/weapon/ranged/R = A.left_item
				if(R.attachment_stats["zoom_mul"])
					zoom_mul *= R.attachment_stats["zoom_mul"]
	zoom_pixel_x = desired_x_offset*TILE_SIZE*ZOOM_RANGE*zoom_mul
	zoom_pixel_y = desired_y_offset*TILE_SIZE*ZOOM_RANGE*zoom_mul



/client/proc/handle_camera()

	if(mob && !mob.z && mob.loc)
		var/atom/A = mob.loc
		pixel_x = round(A.pixel_x,1)
		pixel_y = round(A.pixel_y,1)
		return TRUE

	var/calculated_pixel_x = 0
	var/calculated_pixel_y = 0

	var/desired_punch_x = 0
	var/desired_punch_y = 0
	if(queued_shakes > 0)
		desired_punch_x = rand(-TILE_SIZE*4,TILE_SIZE*4)
		desired_punch_y = rand(-TILE_SIZE*4,TILE_SIZE*4)
		queued_shakes--

	var/zoom_offset_x = is_zoomed ? zoom_pixel_x : 0
	var/zoom_offset_y = is_zoomed ? zoom_pixel_y : 0

	var/desired_pixel_x = zoom_offset_x + desired_punch_x //Where we want to move.
	var/desired_pixel_y = zoom_offset_y + desired_punch_y //Where we want to move.

	var/total_difference = abs(desired_pixel_x - final_pixel_x) + abs(desired_pixel_y - final_pixel_y)
	var/diff_mod = clamp(total_difference*0.1,1,20)
	var/max_speed = CEILING(TILE_SIZE * 0.1 * diff_mod,1)
	var/x_mod = clamp(desired_pixel_x - final_pixel_x,-max_speed,max_speed) //How fast we can move.
	var/y_mod = clamp(desired_pixel_y - final_pixel_y,-max_speed,max_speed) //How fast we can move.
	final_pixel_x += x_mod
	final_pixel_y += y_mod

	calculated_pixel_x += final_pixel_x
	calculated_pixel_y += final_pixel_y

	var/time_mul = TICKS_TO_DECISECONDS(CLIENT_TICK)

	for(var/k in queued_recoil)
		var/list/data = k
		var/current_x = data[1]
		var/current_y = data[2]
		var/initial_recoil_x = data[3]
		var/initial_recoil_y = data[4]

		var/initial_speed_mul_x = data[5]
		var/initial_speed_mul_y = data[6]

		var/recovery_speed_mul_x = data[7] * time_mul
		var/recovery_speed_mul_y = data[8] * time_mul

		var/recovering = data[9]

		var/finished = 0

		//x
		var/x_diff = 0
		if(!recovering) // Going forward. Initial.
			x_diff = clamp(initial_recoil_x - current_x,-initial_speed_mul_x,initial_speed_mul_x)
		else
			x_diff = clamp(0 - current_x,-recovery_speed_mul_x,recovery_speed_mul_x)
		if(x_diff)
			data[1] += x_diff
		else
			finished++

		//y
		var/y_diff = 0
		if(!recovering) // Going forward. Initial.
			y_diff = clamp(initial_recoil_y - current_y,-initial_speed_mul_y,initial_speed_mul_y)
		else
			y_diff = clamp(0 - current_y,-recovery_speed_mul_y,recovery_speed_mul_y)
		if(y_diff)
			data[2] = data[2] + y_diff
		else
			finished++

		if(finished >= 2)
			if(recovering)
				queued_recoil -= k
			else
				data[9] = TRUE //recovering

		calculated_pixel_x += data[1]
		calculated_pixel_y += data[2]

	//animate(src,pixel_x = calculated_pixel_x, pixel_y = calculated_pixel_y, time = TICKS_TO_DECISECONDS(CLIENT_TICK))

	pixel_x = round(calculated_pixel_x,1)
	pixel_y = round(calculated_pixel_y,1)

	return TRUE


/client/proc/add_queued_recoil(var/initial_recoil_x=0,var/initial_recoil_y=0,var/initial_speed=1,var/recovery_speed=1,var/recovering=FALSE)

	initial_speed = abs(initial_speed)
	recovery_speed = abs(recovery_speed)

	var/abs_initial_recoil_x = abs(initial_recoil_x)
	var/abs_initial_recoil_y = abs(initial_recoil_y)

	var/speed_mul_x = abs_initial_recoil_x < abs_initial_recoil_y ? abs_initial_recoil_x/abs_initial_recoil_y : 1
	var/speed_mul_y = abs_initial_recoil_y < abs_initial_recoil_x ? abs_initial_recoil_y/abs_initial_recoil_x : 1

	var/desired_speed_x = initial_speed * speed_mul_x
	var/desired_speed_y = initial_speed * speed_mul_y

	if(desired_speed_x > 0)
		desired_speed_x = max(TILE_SIZE*0.5,desired_speed_x) //Get largest.
	else if(desired_speed_x < 0)
		desired_speed_x = min(-TILE_SIZE*0.5,desired_speed_x) //Get smallest

	if(desired_speed_y > 0)
		desired_speed_y = max(TILE_SIZE*0.5,desired_speed_y) //Get largest.
	else if(desired_speed_y < 0)
		desired_speed_y = min(-TILE_SIZE*0.5,desired_speed_y) //Get smallest

	queued_recoil += list(list(
		0,
		0,
		clamp(initial_recoil_x,-TILE_SIZE*2,TILE_SIZE*2),
		clamp(initial_recoil_y,-TILE_SIZE*2,TILE_SIZE*2),
		desired_speed_x,
		desired_speed_y,
		recovery_speed * speed_mul_x,
		recovery_speed * speed_mul_y,
		recovering
	))

	return TRUE