/mob/living/simple/gorilla
	name = "gorilla"
	desc = "Danger: Very robust."
	icon = 'icons/mob/living/simple/gorilla.dmi'
	icon_state = "living"

	damage_type = /damagetype/npc/gorilla

	ai = /ai/

	health_base = 1000
	stamina_base = 1000
	mana_base = 50

	value = 400

	size = SIZE_LARGE

	movement_delay = DECISECONDS_TO_TICKS(5)

	loyalty_tag = "Gorilla"
	iff_tag = "Gorilla"

	blood_type = /reagent/blood/human/o_negative
	blood_volume = 750

	soul_size = SOUL_SIZE_COMMON

	level = 24