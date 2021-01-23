/mob/living/simple/arachnid
	name = "giant arachnid"
	desc = "Might as well be a miniboss."
	desc_extended = "A giant quadreped carniverous creature."
	icon = 'icons/mob/living/simple/jungle/arachnid.dmi'
	icon_state = "living"
	damage_type = /damagetype/unarmed/claw/
	class = /class/arachnid

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

	pixel_x = -16

	armor_base = list(
		BLADE = AP_SWORD,
		BLUNT = AP_SWORD,
		PIERCE = AP_DAGGER,
		LASER = -AP_SWORD,
		HEAT = AP_AXE,
		COLD = -AP_AXE,
		BIO = AP_CLUB,
		FATIGUE = AP_SWORD,
		ION = INFINITY,
		PAIN = AP_CLUB
	)

	iff_tag = "Jungle"
	loyalty_tag = "Jungle"

	health_base = 500
	stamina_base = 250
	mana_base = 250

	movement_delay = DECISECONDS_TO_TICKS(2)

	mob_size = MOB_SIZE_GIANT

	enable_medical_hud = FALSE
	enable_security_hud = FALSE

	blood_type = /reagent/blood/alien/green
	blood_volume = 2000

/mob/living/simple/arachnid/post_death()
	. = ..()
	icon_state = "dead"
	update_sprite()