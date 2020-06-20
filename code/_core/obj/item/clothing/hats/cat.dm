/obj/item/clothing/head/hat/cat
	name = "\improper cursed cat ears"
	icon = 'icons/obj/items/clothing/hats/cat.dmi'
	desc = "why the fuck would you wear this"
	desc_extended = "don't fucking wear this"
	rarity = RARITY_LEGENDARY

	defense_rating = list(
		HOLY = -100,
		DARK = 100
	)

	protected_limbs = TARGETABLE_LIMBS

	size = SIZE_2
	weight = WEIGHT_5

	no_initial_blend = TRUE

	dyeable = TRUE

	polymorphs = list(
		"outer" = "#FFFFFF",
		"inner" = "#FF8888"
	)

	worn_layer = LAYER_MOB_HAIR_HEAD + 0.01

	value = 200