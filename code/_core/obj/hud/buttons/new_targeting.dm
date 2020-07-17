/obj/hud/button/targeting_new
	name = "limb targeting"
	desc = "Aim for the head!"
	desc_extended = "Where you press determines where you attack."
	icon = 'icons/hud/paperdoll.dmi'
	icon_state = "base"
	screen_loc = "RIGHT:-1,BOTTOM"

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


/obj/hud/button/targeting_new/update_owner(var/mob/desired_owner)

	. = ..()

	if(. && owner)
		update_overlays()

	return .


/obj/hud/button/targeting_new/clicked_on_by_object(var/mob/caller,var/atom/object,location,control,params)

	. = ..()

	if(. && is_player(caller) && caller.client)
		var/mob/living/advanced/player/P = caller
		var/click_flags = P.client.get_click_flags(params,TRUE)
		if(!params || !params[PARAM_ICON_X] || !params[PARAM_ICON_Y])
			return .
		var/x_click = text2num(params[PARAM_ICON_X])/2
		var/y_click = text2num(params[PARAM_ICON_Y])/2

		if(x_click <= 26)
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
		update_overlays()

	return .

/obj/hud/button/targeting_new/update_overlays()

	overlays.Cut()

	. = ..()

	var/image/left_overlay = new /image(initial(icon),"targeting_r")
	left_overlay.pixel_x = (left[mode][1] - 16)*2
	left_overlay.pixel_y = (left[mode][2] + 1 - 16)*2

	var/image/right_overlay = new /image(initial(icon),"targeting_l")
	right_overlay.pixel_x = (right[mode][1] - 16)*2
	right_overlay.pixel_y = (right[mode][2] + 1 - 16)*2

	var/image/preset_overlay = new /image(initial(icon),"target_selection_[mode]")
	var/color_scheme = owner.client.settings.loaded_data["hud_colors"]
	preset_overlay.color = color_scheme[4]

	add_overlay(left_overlay)
	add_overlay(right_overlay)
	add_overlay(preset_overlay)

	return .