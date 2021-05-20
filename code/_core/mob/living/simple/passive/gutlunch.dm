/mob/living/simple/passive/gutlunch
	name = "gutlunch"
	desc = "A disgusting name for a moderately disgusting creature."
	desc_extended = "A mostly passive lavaland critter that feeds on the blood and corpses of local wildlife."

	icon = 'icons/mob/living/simple/gutlunch.dmi'
	icon_state = "1"

	damage_type = /damagetype/npc/cow

	butcher_contents = list(
		/obj/item/container/food/dynamic/meat/raw,
		/obj/item/container/food/dynamic/meat/raw,
		/obj/item/container/food/dynamic/meat/raw,
		/obj/item/container/food/dynamic/meat/raw
	)

	size = SIZE_ANIMAL

	iff_tag = "Gutlunch"
	loyalty_tag = "Gutlunch"

	blood_type = /reagent/blood/gutlunch
	blood_volume = 300

	health_base = 100
	stamina_base = 50
	mana_base = 25

/mob/living/simple/passive/gutlunch/Generate()
	. = ..()
	icon_state = "[rand(1,3)]"

/mob/living/simple/passive/gutlunch/post_death()
	..()
	icon_state = "dead"