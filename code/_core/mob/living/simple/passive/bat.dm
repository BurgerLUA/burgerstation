/mob/living/simple/bat
	name = "cave bat"
	desc = "Spooky!"
	desc_extended = "A very aggressive cave bat."
	icon = 'icons/mob/living/simple/bat.dmi'
	icon_state = "living"

	health_base = 20
	stamina_base = 10
	mana_base = 10

	damage_type = /damagetype/unarmed/bite/

	stun_angle = 0

	iff_tag = "Bat"
	loyalty_tag = "Bat"

	size = SIZE_CRITTER

	blood_type = /reagent/blood/bat
	blood_volume = 100

	soul_size = SOUL_SIZE_COMMON

	level = 4

/mob/living/simple/bat/post_death()
	. = ..()
	icon_state = "dead"
