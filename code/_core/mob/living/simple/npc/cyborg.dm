/mob/living/simple/npc/silicon/
	name = "robot"
	icon = 'icons/mob/living/simple/robots.dmi'
	icon_state = "robot_old"

	damage_type = "cult_blade"

	ai = /ai/

	enable_medical_hud = FALSE
	enable_security_hud = FALSE

	blood_color = "#262626"

	value = 100

/mob/living/simple/npc/silicon/engineer
	name = "engineer cyborg"
	icon_state = "engineer"

	damage_type = "cult_blade"


/mob/living/simple/npc/silicon/engineer/PostInitialize()
	. = ..()
	flick("engineer_transform",src)
	return .


/mob/living/simple/npc/silicon/squats
	name = "S.Q.U.A.T.S."
	icon_state = "squats"

	damage_type = "squats_punch"

	class = /class/squats

	movement_delay = DECISECONDS_TO_TICKS(2)

	health_base = 500

	sprint_delay_mul = 1
	jog_delay_mul = 3
	walk_delay_mul = 3

	armor_base = list(
		BLADE = 25,
		BLUNT = 25,
		PIERCE = 75,
		LASER = 50,
		MAGIC = -50,
		HEAT = 75,
		COLD = 75,
		BOMB = 25,
		BIO = INFINITY,
		RAD = INFINITY,
		HOLY = INFINITY,
		DARK = INFINITY,
		FATIGUE = INFINITY
	)

	iff_tag = "Syndicate"
	loyalty_tag = "Syndicate"

	damage_type = /damagetype/squats/

	status_immune = list(
		FIRE = TRUE
	)

/mob/living/simple/npc/silicon/squats/post_death()

	. = ..()
	icon_state = "squats-dead"
	update_sprite()
	return .


/mob/living/simple/npc/silicon/squats/PostInitialize()
	. = ..()
	update_sprite()
	return .

/mob/living/simple/npc/silicon/squats/update_overlays()

	if(!health || icon_state == "squats-roll" || icon_state == "squats-dead")
		damage_received_multiplier = initial(damage_received_multiplier)
		return ..()

	var/image/I = new/image(icon,"squats-shield")
	add_overlay(I)
	damage_received_multiplier = 0.1

	return ..()

/mob/living/simple/npc/silicon/squats/on_sprint()
	. = ..()

	if(.)
		if(icon_state != "squats-roll")
			icon_state = "squats-roll"
			update_sprite()

	return .

/mob/living/simple/npc/silicon/squats/on_jog()

	. = ..()

	if(.)
		if(icon_state != "squats")
			icon_state = "squats"
			update_sprite()

	return .

/mob/living/simple/npc/silicon/squats/on_walk()

	. = ..()

	if(.)
		if(icon_state != "squats")
			icon_state = "squats"
			update_sprite()

	return .