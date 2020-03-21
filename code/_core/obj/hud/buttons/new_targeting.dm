/obj/hud/button/targeting_new
	name = "limb targeting"
	desc = "Aim for the head!"
	desc_extended = "Where you press determines where you attack."
	icon_state = "target_selection_new"
	screen_loc = "RIGHT,BOTTOM"

	flags = FLAGS_HUD_MOB

	var/mode = 1

	var/list/left = list(
		list(16,16),
		list(16,16),
		list(16,16)
	)

	var/list/right = list(
		list(16,16),
		list(16,16),
		list(16,16)
	)


/obj/hud/button/targeting_new/update_owner()

	. = ..()

	update_overlay()

	return .


/obj/hud/button/targeting_new/clicked_on_by_object(var/mob/caller,object,location,control,params)

	if(!is_player(caller))
		return

	if(!caller.client)
		return

	var/mob/living/advanced/player/P = caller

	var/click_flags = P.client.get_click_flags(params,TRUE)

	if(!(params[PARAM_ICON_X] && params[PARAM_ICON_Y]))
		return

	var/x_click = text2num(params[PARAM_ICON_X])
	var/y_click = text2num(params[PARAM_ICON_Y])

	if(x_click >= 7)
		if(click_flags & CLICK_LEFT)
			left[mode] = list(x_click,y_click - 1)
		if(click_flags & CLICK_RIGHT)
			right[mode] = list(x_click,y_click - 1)
	else
		switch(y_click)
			if(9 to 15)
				mode = 3
			if(17 to 23)
				mode = 2
			if(25 to 31)
				mode = 1

	P.attack_mode = mode
	P.attack_right = right
	P.attack_left = left
	update_overlay()

	return ..()

/obj/hud/button/targeting_new/proc/update_overlay()

	overlays.Cut()

	var/image/left_overlay = new /image(initial(icon),"targeting_r")
	left_overlay.pixel_x = left[mode][1] - 16
	left_overlay.pixel_y = left[mode][2] + 1 - 16

	var/image/right_overlay = new /image(initial(icon),"targeting_l")
	right_overlay.pixel_x = right[mode][1] - 16
	right_overlay.pixel_y = right[mode][2] + 1 - 16

	var/image/preset_overlay = new /image(initial(icon),"target_selection_[mode]")
	preset_overlay.color = "#00FFFF"

	//var/image/body_overlay = new /image(icon,"body_full")

	//overlays += body_overlay
	overlays += left_overlay
	overlays += right_overlay
	overlays += preset_overlay

	return TRUE