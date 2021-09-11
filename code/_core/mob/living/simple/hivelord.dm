/mob/living/simple/hivelord
	name = "hivelord"
	desc = "From the depths."
	desc_extended = "A manifestation of dark energy."
	icon = 'icons/mob/living/simple/hivelord.dmi'
	icon_state = "living"

	ai = /ai/

	health_base = 20
	stamina_base = 10
	mana_base = 10

	damage_type = /damagetype/npc/hivelord


	stun_angle = 0

	iff_tag = "Hell"
	loyalty_tag = "Hell"

	size = SIZE_CRITTER

	blood_type = /reagent/blood/unholy
	blood_volume = 100

	soul_size = SOUL_SIZE_COMMON

	level = 12

/mob/living/simple/hivelord/post_death()
	. = ..()
	icon_state = "dead"
