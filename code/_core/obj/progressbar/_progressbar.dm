/obj/progress_bar
	name = "progress bar"
	icon = 'icons/hud/inventory.dmi'
	icon_state = "progress"

	layer = LAYER_HUD
	plane = PLANE_HUD

	var/bar_color = "#ffffff"

	var/start_time = 0
	var/end_time = 0

/obj/progress_bar/New(var/atom/new_loc,var/new_id,var/new_start_time,var/new_end_time)

	if(is_mob(new_loc))
		screen_loc = "CENTER,CENTER+1"
		loc = new_loc
		var/mob/M = new_loc
		if(M.client)
			M.client.screen += src
	else
		pixel_y = TILE_SIZE
		loc = new_loc.loc

	id = new_id
	start_time = new_start_time
	end_time = new_end_time
	..()

/obj/progress_bar/update_icon()

	icon = initial(icon)

	var/icon/I = new/icon(icon,icon_state)
	var/icon/O = new/icon(icon,"progress_bar")
	var/time_normalized = end_time - start_time
	var/time_left = end_time - curtime
	var/time_mul = 1 - (time_left/time_normalized)
	var/x_offset = 4

	O.Crop(0,0,x_offset + (TILE_SIZE-x_offset)*time_mul,TILE_SIZE)
	I.Blend(O,ICON_OVERLAY)

	icon = I

/obj/progress_bar/destroy()

	if(is_mob(loc))
		var/mob/M = loc
		if(M.client)
			M.client.screen -= src

	return ..()