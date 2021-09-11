/mob/living/simple/bull

	name = "angry bull"
	desc = "Protector of cows."
	desc_extended = "Can be seen protecting grasslands from pesky humanoids."
	icon = 'icons/mob/living/simple/passive.dmi'
	icon_state = "bull"

	health_base = 100
	stamina_base = 100
	mana_base = 50

	value = 50

	butcher_contents = list(
		/obj/item/container/food/dynamic/meat/raw,
		/obj/item/container/food/dynamic/meat/raw,
		/obj/item/container/food/dynamic/meat/raw
	)


	ai = /ai/

	damage_type = /damagetype/npc/bull

	armor_base = list(
		BLUNT = 20,
		PIERCE = 40,
		LASER = -20,
		ARCANE = 20,
		HOLY = 40,
		DARK = 40,
		ION = INFINITY
	)

	size = SIZE_LARGE

	iff_tag = "Cow"
	loyalty_tag = "Cow"

	enable_medical_hud = FALSE
	enable_security_hud = FALSE

	blood_type = /reagent/blood/cow
	blood_volume = 500

	soul_size = SOUL_SIZE_COMMON

	level = 12

/mob/living/simple/bull/post_death()
	..()
	icon_state = "[initial(icon_state)]_dead"
	update_sprite()