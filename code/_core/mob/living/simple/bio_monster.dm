/mob/living/simple/bio_monster
	name = "bio monster"
	desc = "Experiments gone wrong."
	desc_extended = "A clusterfuck of flesh created from some man-made experiment gone wrong. Or perhaps right."
	icon = 'icons/mob/living/simple/bio_monster.dmi'
	icon_state = "living"

	health_base = 100
	stamina_base = 100
	mana_base = 50

	value = 100

	ai = /ai/

	damage_type = /damagetype/npc/bio_monster

	armor_base = list(
		BLUNT = 40,
		LASER = -40,
		HEAT = -40,
		COLD = 40,
		BOMB = -40,
		BIO = INFINITY,
		RAD = INFINITY,
		FATIGUE = INFINITY,
		ION = INFINITY,
		PAIN = INFINITY
	)

	size = SIZE_LARGE

	movement_delay = DECISECONDS_TO_TICKS(3)

	iff_tag = "Experiment"
	loyalty_tag = "Experiment"

	stun_angle = 0

	enable_medical_hud = FALSE
	enable_security_hud = FALSE

	blood_volume = 500
	blood_type = /reagent/blood/blob

	soul_size = SOUL_SIZE_COMMON

	level = 14

/mob/living/simple/bio_monster/post_death()
	. = ..()
	icon_state = "dead"
