/mob/living/simple/exploding_frog
	name = "frog?"
	desc = "*Frog explosion Sounds*"
	desc_extended = "A less than docile frog."
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

	var/exploded = FALSE

	level = 1

/mob/living/simple/exploding_frog/death()

	if(!exploded)
		explode(get_turf(src),30,master ? master : src,src,loyalty_tag)
		exploded = TRUE

	. = ..()

