/mob/living/simple/passive/frog
	name = "frog"
	desc = "*Frog Sounds*"
	desc_extended = "A docile frog."
	icon = 'icons/mob/living/simple/frog.dmi'
	icon_state = "living"
	damage_type = /damagetype/unarmed/bite/


	health_base = 20

	stun_angle = 0

	loyalty_tag = "Lizard"
	iff_tag = "Lizard"

	size = SIZE_CRITTER

	blood_type = /reagent/blood/reptile
	blood_volume = 50

	health_base = 25
	stamina_base = 50
	mana_base = 25

/mob/living/simple/passive/frog/post_death()
	. = ..()
	icon_state = "dead"
	update_sprite()
