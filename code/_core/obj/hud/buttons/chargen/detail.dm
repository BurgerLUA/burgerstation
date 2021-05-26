mob/living/advanced/proc/handle_detail_chargen(var/desired_color,var/update_blends = TRUE) //This needs to be called when the buttons are made visible.

	change_organ_visual("skin_detail", desired_color = desired_color)

	for(var/obj/hud/button/chargen/detail/B in buttons)
		B.detail_color = desired_color

	if(update_blends) update_all_blends()

	return TRUE

/obj/hud/button/chargen/detail
	name = "detail color"
	icon_state = "change_detailcolor"

	screen_loc = "CENTER-3.5,CENTER-2"

	var/detail_color = "#FFFFFF"

	user_colors = TRUE

	chargen_flags = CHARGEN_DETAIL

/obj/hud/button/chargen/detail/clicked_on_by_object(var/mob/caller,var/atom/object,location,control,params)

	. = ..()

	if(. && is_advanced(caller))
		var/mob/living/advanced/A = caller
		var/desired_color = input("Detail Color","Detail Color",detail_color) as color|null
		if(desired_color)
			A.handle_detail_chargen(desired_color)