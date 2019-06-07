/mob/living/simple/npc/slime/
	name = "slime"
	desc = "Oh no. They're here too!"

	icon = 'icons/mob/living/simple/slimes_new.dmi'
	icon_state = "small_neutral"

	var/stored_slimes = 1

	ai = /ai/slime/

	can_attack_while_moving = FALSE

	var/happiness_mod = 0
	var/anger_mod = 0
	var/sadness_mod = 0

	var/slime_color = "#000000"

/mob/living/simple/npc/slime/Initialize()
	. = ..()
	update_icon()
	return .

/mob/living/simple/npc/slime/post_death()
	..()
	update_icon()
	spawn while(stored_slimes > 0)
		var/mob/living/simple/npc/slime/S = new(src.loc)
		S.slime_color = slime_color
		S.update_icon()
		stored_slimes--
		sleep(3)

	//Loot spawning is handled here.
	//Fuck snowflake code but whatever.

/mob/living/simple/npc/slime/update_icon()

	icon = initial(icon)
	icon_state = initial(icon_state)

	var/list/my_rgb = ReadRGB(slime_color)
	var/anger = (my_rgb[1]/255) + anger_mod
	var/happiness = (my_rgb[2]/255) + happiness_mod
	var/sadness = (my_rgb[3]/255) + sadness_mod

	if(status & FLAG_STATUS_DEAD)
		icon_state = "death"
	else if(stored_slimes > 1)
		icon_state = "grow"
	else
		var/mood = "neutral"
		if(anger > happiness && anger > sadness)
			mood = "angry"
		else if(happiness > anger && happiness > sadness)
			mood = "happy"
		else if(sadness > anger && sadness > happiness)
			mood = "sad"
		icon_state = "small_[mood]"

	var/face_state = "none"

	if(anger > happiness + sadness)
		face_state = "angry"
	else if(happiness > anger + sadness)
		face_state = "mischevous"
	else if(sadness > anger + happiness)
		face_state = "sad"

	var/icon/I = new(icon,icon_state)
	I.Blend(slime_color,ICON_MULTIPLY)
	var/icon/I2 = new(icon,"emotion_[face_state]")
	I.Blend(I2,ICON_OVERLAY)

	icon = I

/mob/living/simple/npc/slime/proc/absorb_slime(var/mob/living/simple/npc/slime/desired_slime)

	if(desired_slime == src)
		return FALSE

	stored_slimes += desired_slime.stored_slimes

	var/list/my_rgb = ReadRGB(src.slime_color)
	var/list/stored_rgb = ReadRGB(desired_slime.slime_color)

	//var/average_alpha = round( (src.alpha + desired_slime.alpha)/2 )

	var/new_r = (my_rgb[1] + stored_rgb[1]) * 0.5
	var/new_g = (my_rgb[2] + stored_rgb[2]) * 0.5
	var/new_b = (my_rgb[3] + stored_rgb[3]) * 0.5
	src.slime_color = rgb(new_r,new_g,new_b)
	update_icon()

	qdel(desired_slime)

	return TRUE


//Black
/mob/living/simple/npc/slime/grey
	color = "#888888"

/mob/living/simple/npc/slime/grey/pure
	color = "#FFFFFF"

/mob/living/simple/npc/slime/grey/dark
	color = "#444444"


//Red
/mob/living/simple/npc/slime/red
	slime_color = "#880000"

/mob/living/simple/npc/slime/red/dark
	slime_color = "#440000"
/mob/living/simple/npc/slime/red/pure
	slime_color = "#FF0000"

//Green
/mob/living/simple/npc/slime/green
	slime_color = "#008800"

/mob/living/simple/npc/slime/green/dark
	slime_color = "#004400"

/mob/living/simple/npc/slime/green/pure
	slime_color = "#00FF00"


//Blue
/mob/living/simple/npc/slime/blue
	slime_color = "#000088"

/mob/living/simple/npc/slime/blue/dark
	slime_color = "#000044"

/mob/living/simple/npc/slime/blue/pure
	slime_color = "#0000FF"


//Cyan
/mob/living/simple/npc/slime/cyan
	slime_color = "#008888"

/mob/living/simple/npc/slime/cyan/dark
	slime_color = "#004444"

/mob/living/simple/npc/slime/cyan/pure
	slime_color = "#00FFFF"