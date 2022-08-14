/mob/living/simple/slime/
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

	color = "#888888"

	health_base = 50
	stamina_base = 100
	mana_base = 100

	value = 100

	armor = /armor/slime

	size = SIZE_ANIMAL

	damage_type = /damagetype/npc/slime

	enable_medical_hud = FALSE
	enable_security_hud = FALSE

	iff_tag = "Slime"
	loyalty_tag = "Slime"

	stun_angle = 0

	blood_type = null

	soul_size = SOUL_SIZE_COMMON

	level = 8


/mob/living/simple/slime/create_override_contents(var/mob/living/caller) //What gets created when this mob is butchered.
	var/obj/item/slime_core/SC = new(src.loc)
	SC.color = color
	SC.alpha = alpha
	INITIALIZE(SC)
	FINALIZE(SC)
	return TRUE

/mob/living/simple/slime/Finalize()
	. = ..()
	update_sprite()

/mob/living/simple/slime/post_death()
	. = ..()
	update_sprite()

/mob/living/simple/slime/check_death()

	. = ..()

	if(.) //Would result in death.
		if(stored_slimes <= 1) //Yeah you're dead, kiddo.
			return .

		var/ratio = 1/stored_slimes

		for(var/k in src.health.damage)
			src.health.damage[k] *= ratio

		for(var/i=1,i<=stored_slimes-1,i++) //Big slimes split.
			var/mob/living/simple/slime/S = new(get_turf(src))
			S.color = color
			S.stored_slimes = 1
			INITIALIZE(S)
			FINALIZE(S)
			if(S.health)
				S.health.damage = src.health.damage.Copy()
			S.health.update_health()
			var/turf/T = get_step(src,pick(DIRECTIONS_ALL))
			if(T) S.Move(T)
		var/turf/T = get_step(src,pick(DIRECTIONS_ALL))
		src.Move(T)
		src.stored_slimes = 1
		src.health.update_health()
		src.update_sprite()
		src.add_status_effect(STUN,20,20)
		create_alert(VIEW_RANGE,T,null,ALERT_LEVEL_CAUTION) //Wake the new slimes.
		return FALSE


/mob/living/simple/slime/update_overlays()

	. = ..()

	var/list/my_rgb = ReadRGB(color ? color : "#FFFFFF")
	var/anger = (my_rgb[1]/255) + anger_mod
	var/happiness = (my_rgb[2]/255) + happiness_mod
	var/sadness = (my_rgb[3]/255) + sadness_mod

	var/mood = "neutral"
	if(anger > happiness && anger > sadness)
		mood = "angry"
	else if(happiness > anger && happiness > sadness)
		mood = "happy"
	else if(sadness > anger && sadness > happiness)
		mood = "sad"

	if(dead)
		icon_state = "death"
	else  if(stored_slimes > 1)
		icon_state = "large"
	else
		icon_state = "small_[mood]"

	if(!dead)
		var/face_state = "none"
		if(anger > happiness + sadness)
			face_state = "angry"
		else if(happiness > anger + sadness)
			face_state = "mischevous"
		else if(sadness > anger + happiness)
			face_state = "sad"
		var/image/I = new(initial(icon),"emotion_[face_state]")
		I.appearance_flags = appearance_flags | RESET_COLOR | RESET_ALPHA
		add_overlay(I)

/mob/living/simple/slime/proc/absorb_slime(var/mob/living/simple/slime/desired_slime)

	if(desired_slime == src) //Can't absorb self.
		return FALSE

	var/stored_ratio = desired_slime.stored_slimes / (stored_slimes + desired_slime.stored_slimes)
	var/stored_ratio_inverse = 1 - stored_ratio

	stored_slimes += desired_slime.stored_slimes //Number of stored slimes.

	var/list/my_rgb = ReadRGB(src.color ? src.color : "#FFFFFF")
	var/list/stored_rgb = ReadRGB(desired_slime.color ? desired_slime.color : " #FFFFFF")
	var/new_r = (my_rgb[1] * stored_ratio_inverse) + (stored_rgb[1] * stored_ratio)
	var/new_g = (my_rgb[2] * stored_ratio_inverse) + (stored_rgb[2] * stored_ratio)
	var/new_b = (my_rgb[3] * stored_ratio_inverse) + (stored_rgb[3] * stored_ratio)
	var/new_a = (src.alpha * stored_ratio_inverse) + (desired_slime.alpha * stored_ratio)

	var/new_color = rgb(new_r,new_g,new_b)
	animate(src,alpha=new_a,color=new_color,time=SECONDS_TO_DECISECONDS(2))
	src.alpha = new_a
	src.color = new_color

	src.update_sprite()

	if(src.health && desired_slime.health) //Heal brute and burn, damage from tox.
		var/brute_to_restore = desired_slime.health.health_max - desired_slime.health.damage[BRUTE]
		var/burn_to_restore = desired_slime.health.health_max - desired_slime.health.damage[BURN]
		var/tox_to_add = desired_slime.health.damage[TOX]
		if(brute_to_restore || burn_to_restore || tox_to_add)
			src.health.adjust_loss_smart(brute=-brute_to_restore,burn=-burn_to_restore,tox=tox_to_add)

	qdel(desired_slime)

	return TRUE

//Black
/mob/living/simple/slime/grey
	color = "#888888"

/mob/living/simple/slime/grey/pure
	color = "#FFFFFF"

/mob/living/simple/slime/grey/dark
	color = "#444444"


//Red
/mob/living/simple/slime/red
	color = "#880000"

/mob/living/simple/slime/red/dark
	color = "#440000"
/mob/living/simple/slime/red/pure
	color = "#FF0000"

//Green
/mob/living/simple/slime/green
	color = "#008800"

/mob/living/simple/slime/green/dark
	color = "#004400"

/mob/living/simple/slime/green/pure
	color = "#00FF00"

//Blue
/mob/living/simple/slime/blue
	color = "#000088"

/mob/living/simple/slime/blue/dark
	color = "#000044"

/mob/living/simple/slime/blue/pure
	color = "#0000FF"


//Cyan
/mob/living/simple/slime/cyan
	color = "#008888"

/mob/living/simple/slime/cyan/dark
	color = "#004444"

/mob/living/simple/slime/cyan/pure
	color = "#00FFFF"