/mob/living/simple/npc/silicon/
	name = "robot"
	icon = 'icons/mob/living/simple/robots.dmi'
	icon_state = "robot_old"

	damage_type = "cult_blade"

	ai = /ai/

	enable_medical_hud = FALSE
	enable_security_hud = FALSE

	blood_type = /reagent/blood/robot

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

	health = /health/mob/living/simple/npc/squats/
	class = /class/squats

	movement_delay = 2

	health_base = 300

	sprint_delay_mul = 1
	jog_delay_mul = 3
	walk_delay_mul = 3

	armor_base = list(
		BLADE = 25,
		BLUNT = 25,
		PIERCE = 75,
		LASER = 50,
		ARCANE = -50,
		HEAT = 75,
		COLD = 75,
		BOMB = 25,
		BIO = INFINITY,
		RAD = INFINITY,
		HOLY = INFINITY,
		DARK = INFINITY,
		FATIGUE = INFINITY,
		ION = 0
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
	return .

/mob/living/simple/npc/silicon/squats/Finalize()
	. = ..()
	update_sprite()
	return .

/mob/living/simple/npc/silicon/squats/update_overlays()
	. = ..()
	if(!dead && health && health.health_current >= health.health_max * 0.5)
		var/icon/I = new/icon(initial(icon),"squats-shield")
		add_overlay(I)
	return .