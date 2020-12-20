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
	class = /class/bull
	damage_type = /damagetype/npc/bull

	armor_base = list(
		BLUNT = AP_SWORD,
		PIERCE = AP_AXE,
		LASER = -AP_SWORD,
		ARCANE = AP_SWORD,
		HOLY = AP_AXE,
		DARK = AP_AXE,
		ION = INFINITY
	)

	mob_size = MOB_SIZE_LARGE

	iff_tag = "Cow"
	loyalty_tag = "Cow"

	enable_medical_hud = FALSE
	enable_security_hud = FALSE

	blood_type = /reagent/blood/cow
	blood_volume = 500

/mob/living/simple/bull/post_death()
	..()
	icon_state = "[initial(icon_state)]_dead"
	update_sprite()