/mob/living/simple/npc/slime/
	name = "slime"
	desc = "Oh no. They're here too."

	icon = 'icons/mob/living/simple/slimes_new.dmi'
	icon_state = "small_neutral"

	var/stored_slimes = 1
	var/stored_slimes_max = 4

	ai = /ai/slime/

	can_attack_while_moving = TRUE

	var/happiness_mod = 0
	var/anger_mod = 0
	var/sadness_mod = 0

	var/slime_color = "#000000"

	value = 100

	armor_base = list(
		BLADE = -25,
		BLUNT = 100,
		PIERCE = 75,
		LASER = -25,
		MAGIC = 50,
		HEAT = 100,
		COLD = -50,
		BOMB = 0,
		BIO = INFINITY,
		RAD = INFINITY,
		HOLY = 75,
		DARK = 75,
		FATIGUE = INFINITY
	)

	mob_size = MOB_SIZE_ANIMAL

	damage_type = /damagetype/npc/slime

	enable_medical_hud = FALSE
	enable_security_hud = FALSE

	iff_tag = "Slime"
	loyalty_tag = "Slime"

/mob/living/simple/npc/slime/PostInitialize()
	. = ..()
	update_sprite()
	return .

/mob/living/simple/npc/slime/post_death()

	. = ..()

	if(stored_slimes <= 1)
		var/obj/item/slime_core/SC = new(src.loc)
		SC.color = slime_color
		INITIALIZE(SC)

	for(var/i=1,i<=stored_slimes-1,i++)
		var/mob/living/simple/npc/slime/S = new(get_turf(src))
		S.slime_color = slime_color
		S.stored_slimes = 1
		INITIALIZE(S)

		var/xvel = rand(-1,1)
		var/yvel = rand(-1,1)

		if(xvel == 0 && yvel == 0)
			xvel = pick(-1,1)
			yvel = pick(-1,1)

		S.throw_self(src,null,16,16,xvel*5,yvel*5)

	stored_slimes = 0

	update_sprite()

	return .

/mob/living/simple/npc/slime/update_icon()

	icon = initial(icon)
	icon_state = initial(icon_state)

	var/list/my_rgb = ReadRGB(slime_color)
	var/anger = (my_rgb[1]/255) + anger_mod
	var/happiness = (my_rgb[2]/255) + happiness_mod
	var/sadness = (my_rgb[3]/255) + sadness_mod
	var/face_state = "none"

	if(dead)
		icon_state = "death"
	else if(stored_slimes > 1)
		icon_state = "large"
	else
		var/mood = "neutral"
		if(anger > happiness && anger > sadness)
			mood = "angry"
		else if(happiness > anger && happiness > sadness)
			mood = "happy"
		else if(sadness > anger && sadness > happiness)
			mood = "sad"
		icon_state = "small_[mood]"

		if(anger > happiness + sadness)
			face_state = "angry"
		else if(happiness > anger + sadness)
			face_state = "mischevous"
		else if(sadness > anger + happiness)
			face_state = "sad"

	var/icon/I = new(icon,icon_state)
	I.Blend(slime_color,ICON_MULTIPLY)
	if(icon_state != "death")
		var/icon/I2 = new(icon,"emotion_[face_state]")
		I.Blend(I2,ICON_OVERLAY)

	icon = I

	return ..()

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
	update_sprite()

	qdel(desired_slime)

	return TRUE

//Black
/mob/living/simple/npc/slime/grey
	slime_color = "#888888"

/mob/living/simple/npc/slime/grey/pure
	slime_color = "#FFFFFF"

/mob/living/simple/npc/slime/grey/dark
	slime_color = "#444444"


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