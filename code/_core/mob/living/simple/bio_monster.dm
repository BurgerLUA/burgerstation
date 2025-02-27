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

	armor = /armor/blob

	size = SIZE_GIANT

	movement_delay = DECISECONDS_TO_TICKS(3)

	iff_tag = "Experiment"
	loyalty_tag = "Experiment"

	stun_angle = 0

	enable_medical_hud = FALSE
	enable_security_hud = FALSE

	blood_volume = 500
	blood_type = /reagent/blood/blob

	level = 7

/mob/living/simple/bio_monster/post_death()
	. = ..()
	icon_state = "dead"
