/mob/living/simple/passive/cow
	name = "cow"
	desc = "Gives out milk and homework."
	desc_extended = "A harmless critter."

	icon = 'icons/mob/living/simple/cow.dmi'
	icon_state = "living"

	damage_type = /damagetype/npc/cow

	butcher_contents = list(
		/obj/item/container/food/dynamic/meat/raw,
		/obj/item/container/food/dynamic/meat/raw,
		/obj/item/container/food/dynamic/meat/raw,
		/obj/item/container/food/dynamic/meat/raw
	)

	size = SIZE_HUMAN

	iff_tag = "Cow"
	loyalty_tag = "Cow"

	blood_type = /reagent/blood/cow
	blood_volume = 750

	health_base = 100
	stamina_base = 50
	mana_base = 25

/mob/living/simple/passive/cow/post_death()
	..()
	icon_state = "dead"