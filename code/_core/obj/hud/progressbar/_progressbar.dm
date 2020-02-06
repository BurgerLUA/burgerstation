/obj/hud/progress_bar
	name = "progress bar"
	icon = 'icons/hud/progress.dmi'
	icon_state = "progress"

	layer = LAYER_HUD
	plane = PLANE_HUD

	var/bar_color = "#ffffff"

	var/start_time = 0
	var/end_time = 1

	var/last_num = -1

	user_colors = FALSE

/obj/hud/progress_bar/New(var/atom/new_loc,var/desired_start_time = 0,var/desired_end_time = 1)

	start_time = desired_start_time
	end_time = desired_end_time

	if(is_mob(new_loc))
		screen_loc = "CENTER,CENTER+1"
		loc = new_loc
		var/mob/M = new_loc
		if(M.client)
			M.client.screen += src
	else
		pixel_y = TILE_SIZE
		loc = new_loc.loc

	var/icon/I = new(icon,"progress")
	swap_colors(I)
	underlays += I

	update_icon()

	..()

/obj/hud/progress_bar/update_icon()

	if(end_time - start_time <= 0)
		return ..()

	var/desired_num = floor( (1 - ((end_time - curtime)/(end_time - start_time)))*26 )

	icon_state = "bar_[desired_num]"

	return ..()

/obj/hud/progress_bar/Destroy()

	if(is_mob(loc))
		var/mob/M = loc
		if(M.client)
			M.client.screen -= src

	return ..()