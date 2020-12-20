/mob/living/simple/screech
	name = "screech"
	desc = "OH FUCK MY EARS"
	desc_extended = "What the fuck?"
	icon = 'icons/mob/living/simple/screech.dmi'
	icon_state = "screech"
	pixel_x = -16

	health_base = 100
	stamina_base = 100
	mana_base = 100

	value = 1000

	ai =  /ai/
	class = /class/passive/
	damage_type = /damagetype/unarmed/bite/

	enable_security_hud = TRUE
	enable_medical_hud = TRUE

	loyalty_tag = "Screech"
	iff_tag = "Screech"

	mob_size = MOB_SIZE_HUMAN

	blood_type = /reagent/blood/alien/red
	blood_volume = 400