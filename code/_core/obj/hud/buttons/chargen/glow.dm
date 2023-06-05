mob/living/advanced/proc/handle_glow_chargen(var/desired_color,var/update_blends = TRUE) //This needs to be called when the buttons are made visible.

	change_organ_visual("skin_glow", desired_color = desired_color, should_update = update_blends)

	for(var/obj/hud/button/chargen/glow/B in buttons)
		B.glow_color = desired_color

	return TRUE

/obj/hud/button/chargen/glow
	name = "change glow color"
	desc_extended = "Click here to change your character's glow color."
	icon_state = "change_glowcolor"

	screen_loc = "CENTER-2.5,CENTER-2"

	var/glow_color = "#FFFFFF"

	user_colors = TRUE

	chargen_flags = CHARGEN_GLOW

/obj/hud/button/chargen/glow/clicked_on_by_object(var/mob/caller,var/atom/object,location,control,params)

	. = ..()

	if(. && is_advanced(caller))
		var/mob/living/advanced/A = caller
		var/desired_color = input("Glow Color","Glow Color",glow_color) as color|null
		if(desired_color)
			A.handle_glow_chargen(desired_color)