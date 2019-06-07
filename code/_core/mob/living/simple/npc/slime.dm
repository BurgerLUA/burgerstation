/mob/living/simple/npc/slime
	name = "slime"
	desc = "Oh no. They're here too!"

	icon = 'icons/mob/living/simple/slimes.dmi'
	icon_state = "small"

	var/stored_slimes = 1

	ai = /ai/slime/

	can_attack_while_moving = FALSE

	color = "#888888"

/mob/living/simple/npc/slime/Initialize()
	..()
	update_icon()

/mob/living/simple/npc/slime/post_death()
	..()
	update_icon()
	spawn while(stored_slimes > 0)
		var/mob/living/simple/npc/slime/S = new(src.loc)
		S.color = color
		S.update_icon()
		stored_slimes--
		sleep(3)

	//Loot spawning is handled here.
	//Fuck snowflake code but whatever.

/mob/living/simple/npc/slime/update_icon()
	..()
	if(status & FLAG_STATUS_DEAD)
		icon_state = "small_dead_nocore"
	else if(stored_slimes > 1)
		icon_state = "large"
	else
		icon_state = "small"

/mob/living/simple/npc/slime/proc/absorb_slime(var/mob/living/simple/npc/slime/desired_slime)

	if(desired_slime == src)
		return FALSE

	stored_slimes += desired_slime.stored_slimes

	var/list/my_rgb = ReadRGB(src.color)
	var/list/stored_rgb = ReadRGB(desired_slime.color)

	var/average_alpha = round( (src.alpha + desired_slime.alpha)/2 )

	var/new_r = (my_rgb[1] + stored_rgb[1]) * 0.5
	var/new_g = (my_rgb[2] + stored_rgb[2]) * 0.5
	var/new_b = (my_rgb[3] + stored_rgb[3]) * 0.5
	src.color = rgb(new_r,new_g,new_b)
	src.alpha = average_alpha
	update_icon()

	qdel(desired_slime)

	return TRUE

/mob/living/simple/npc/slime/red
	color = "#880000"

/mob/living/simple/npc/slime/white
	color = "#FFFFFF"

/mob/living/simple/npc/slime/grey
	color = "#888888"

/mob/living/simple/npc/slime/black
	color = "#101010"

/mob/living/simple/npc/slime/blue
	color = "#000088"

/mob/living/simple/npc/slime/green
	color = "#008800"