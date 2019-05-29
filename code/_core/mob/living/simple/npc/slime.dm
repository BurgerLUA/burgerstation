/mob/living/simple/slime
	name = "slime"
	desc = "Oh no. They're here too!"

	icon = 'icons/mob/living/simple/slimes.dmi'
	icon_state = "small"

	var/default_color = "#FFFFFF"

	var/mob/living/simple/slime/stored_slime

/mob/living/simple/slime/update_icon()

	..()

	if(stored_slime)
		var/list/my_rgb = ReadRGB(src.default_color)
		var/list/stored_rgb = ReadRGB(stored_slime.default_color)

		var/new_r = (my_rgb[1] + stored_rgb[1])
		var/new_g = (my_rgb[2] + stored_rgb[2])
		var/new_b = (my_rgb[3] + stored_rgb[3])

		color = rgb(new_r,new_g,new_b)
		icon_state = "large"
	else
		color = default_color
		icon_state = "small"


/mob/living/simple/slime/proc/absorb_slime(var/mob/living/simple/slime/desired_slime)
	if(stored_slime || stored_slime.stored_slime)
		return FALSE

	stored_slime = desired_slime
	stored_slime.force_move(src)
	update_icon()
	return TRUE

/mob/living/simple/slime/proc/unabsorb_slime()
	if(!stored_slime)
		return FALSE

	stored_slime.force_move(src.loc)
	stored_slime = null
	update_icon()
	return TRUE