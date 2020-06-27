#define CAMERA_RECOIL_SPEED 8
#define CAMERA_PUNCH_SPEED 6

/client/proc/handle_camera()

	var/zoom_offset_x = 0
	var/zoom_offset_y = 0

	if(is_zoomed)
		var/list/returning_list = direction_to_pixel_offset(is_zoomed)
		zoom_offset_x = returning_list[1]*TILE_SIZE*ZOOM_RANGE
		zoom_offset_y = returning_list[2]*TILE_SIZE*ZOOM_RANGE

	var/final_pixel_x = desired_recoil_x + desired_pixel_x + zoom_offset_x + desired_punch_x
	var/final_pixel_y = desired_recoil_y + desired_pixel_y + zoom_offset_y + desired_punch_y

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