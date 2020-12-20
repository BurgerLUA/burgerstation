/mob/living/simple/passive/cow
	name = "cow"
	desc = "Gives out milk and homework."
	desc_extended = "A harmless critter."
	icon_state = "cow"
	damage_type = /damagetype/npc/cow
	class = /class/cow
	butcher_contents = list(
		/obj/item/container/food/dynamic/meat/raw,
		/obj/item/container/food/dynamic/meat/raw,
		/obj/item/container/food/dynamic/meat/raw,
		/obj/item/container/food/dynamic/meat/raw
	)

	mob_size = MOB_SIZE_HUMAN

	iff_tag = "Cow"
	loyalty_tag = "Cow"

	blood_type = /reagent/blood/cow
	blood_volume = 750

	health_base = 100
	stamina_base = 50
	mana_base = 25

/mob/living/simple/passive/cow/post_death()
	..()
	icon_state = "[initial(icon_state)]_dead"
	update_sprite()