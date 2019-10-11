/obj/hud/button/chargen/skin_color
	name = "skin color"
	icon_state = "body"

	screen_loc = "CENTER-1.5,CENTER-2"

	var/skin_color = "#FFFFFF"

/obj/hud/button/chargen/skin_color/clicked_on_by_object(var/mob/caller,object,location,control,params)

	if(is_advanced(caller))
		var/mob/living/advanced/A = caller
		var/desired_color = input("Skin Color","Skin Color",skin_color) as color
		A.change_organ_visual("skin", desired_color = desired_color)
		skin_color = desired_color
		A.update_all_blends()

	return TRUE

/obj/hud/button/chargen/eye_color
	name = "eye color"
	icon_state = "eyes"

	screen_loc = "CENTER+1.5,CENTER-2"

	var/eye_color = "#FFFFFF"

/obj/hud/button/chargen/eye_color/clicked_on_by_object(var/mob/caller,object,location,control,params)

	if(is_advanced(caller))
		var/mob/living/advanced/A = caller

		var/desired_color = input("Eye Color","Eye Color",eye_color) as color
		A.change_organ_visual("eye", desired_color = desired_color)
		eye_color = desired_color
		A.update_all_blends()

	return TRUE

