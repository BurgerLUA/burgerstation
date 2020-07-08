mob/living/advanced/proc/handle_eyecolor_chargen(var/desired_color,var/update_blends=TRUE) //This needs to be called when the buttons are made visible.
	change_organ_visual("eye", desired_color = desired_color)
	for(var/obj/hud/button/chargen/eye_color/B in buttons)
		B.eye_color = desired_color

	if(update_blends) update_all_blends()

	return TRUE

/obj/hud/button/chargen/eye_color
	name = "eye color"
	icon_state = "change_eyecolor"

	screen_loc = "CENTER+1.5,CENTER-2"

	var/eye_color = "#FFFFFF"

	chargen_flags = CHARGEN_EYE

/obj/hud/button/chargen/eye_color/update_icon()

	var/icon/I = new/icon(icon,icon_state)
	swap_colors(I)
	icon = I

	return ..()

/obj/hud/button/chargen/eye_color/clicked_on_by_object(var/mob/caller,object,location,control,params)

	. = ..()

	if(. && is_advanced(caller))
		var/mob/living/advanced/A = caller
		var/desired_color = input("Eye Color","Eye Color",eye_color) as color|null
		if(desired_color)
			A.handle_eyecolor_chargen(desired_color)

	return .

