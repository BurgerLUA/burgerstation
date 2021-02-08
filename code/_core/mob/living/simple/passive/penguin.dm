/mob/living/simple/passive/penguin
	name = "penguin"
	desc = "Business bird."
	desc_extended = "A harmless critter. Or so it may seem."
	icon = 'icons/mob/living/simple/passive.dmi'
	icon_state = "penguin"
	damage_type = /damagetype/unarmed/bite/
	class = /class/crab

	value = 50

	health_base = 25
	stamina_base = 50
	mana_base = 25

	butcher_contents = list(
		/obj/item/container/food/dynamic/chicken/raw_penguin/,
		/obj/item/container/food/dynamic/chicken/raw_penguin/
	)

	size = SIZE_ANIMAL

	loyalty_tag = "Penguin"
	iff_tag = "Penguin"

	blood_type = /reagent/blood/chicken
	blood_volume = 400

/mob/living/simple/passive/penguin/post_death()
	..()
	icon_state = "[initial(icon_state)]_dead"
	update_sprite()