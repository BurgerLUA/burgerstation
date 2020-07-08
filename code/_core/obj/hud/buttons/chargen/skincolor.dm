mob/living/advanced/proc/handle_skincolor_chargen(var/desired_color,var/update_blends = TRUE) //This needs to be called when the buttons are made visible.

	change_organ_visual("skin", desired_color = desired_color)

	for(var/obj/hud/button/chargen/skin_color/B in buttons)
		B.skin_color = desired_color

	if(update_blends) update_all_blends()

	return TRUE

/obj/hud/button/chargen/skin_color
	name = "skin color"
	icon_state = "change_skincolor"

	screen_loc = "CENTER-1.5,CENTER-2"

	var/skin_color = "#FFFFFF"

	user_colors = TRUE

	chargen_flags = CHARGEN_SKIN

/obj/hud/button/chargen/skin_color/clicked_on_by_object(var/mob/caller,object,location,control,params)

	. = ..()

	if(. && is_advanced(caller))
		var/mob/living/advanced/A = caller
		var/desired_color = input("Skin Color","Skin Color",skin_color) as color|null
		if(desired_color)
			A.handle_skincolor_chargen(desired_color)

	return .