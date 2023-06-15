/mob/living/simple/passive/lizard
	name = "lizard"
	desc = "*Lizard Sounds*"
	desc_extended = "A harmless lizard."
	icon = 'icons/mob/living/simple/lizard.dmi'
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

/mob/living/simple/passive/lizard/post_death()
	. = ..()
	icon_state = "dead"
	update_sprite()
