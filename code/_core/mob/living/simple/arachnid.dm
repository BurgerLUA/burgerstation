/mob/living/simple/arachnid
	name = "giant arachnid"
	desc = "Might as well be a miniboss."
	desc_extended = "A giant quadreped carniverous creature."
	icon = 'icons/mob/living/simple/jungle/arachnid.dmi'
	icon_state = "living"
	damage_type = /damagetype/unarmed/claw/


	pixel_x = -16

	value = 1000

	ai = /ai/

	stun_angle = 0

	butcher_contents = list(
		/obj/item/container/food/dynamic/meat/raw_arachnid,
		/obj/item/container/food/dynamic/meat/raw_arachnid,
		/obj/item/container/food/dynamic/meat/raw_arachnid,
		/obj/item/container/food/dynamic/meat/raw_arachnid,
		/obj/item/container/food/dynamic/meat/raw_arachnid,
		/obj/item/container/food/dynamic/meat/raw_arachnid
	)

	armor_base = list(
		BLADE = 20,
		BLUNT = 20,
		PIERCE = 10,
		LASER = -20,
		HEAT = 40,
		COLD = -40,
		BIO = 60,
		FATIGUE = 20,
		ION = INFINITY,
		PAIN = 60
	)

	iff_tag = "Jungle"
	loyalty_tag = "Jungle"

	health_base = 500
	stamina_base = 250
	mana_base = 250

	movement_delay = DECISECONDS_TO_TICKS(2)

	size = SIZE_GIANT

	enable_medical_hud = FALSE
	enable_security_hud = FALSE

	blood_type = /reagent/blood/alien/green
	blood_volume = 2000

	soul_size = SOUL_SIZE_UNCOMMON

	object_size = 2

	level = 22

/mob/living/simple/arachnid/post_death()
	. = ..()
	icon_state = "dead"
	update_sprite()