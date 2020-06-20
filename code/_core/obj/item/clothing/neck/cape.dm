/obj/item/clothing/neck/cape
	name = "cape"
	icon = 'icons/obj/items/clothing/suit/cape.dmi'


	protected_limbs = list(BODY_TORSO)

	defense_rating = list(
		MAGIC = 25,
		COLD = 25
	)

	rarity = RARITY_UNCOMMON

	size = SIZE_2
	weight = WEIGHT_2

	worn_layer = LAYER_MOB_CLOTHING_NECK_OVER

	dyeable = TRUE

	polymorphs = list(
		"base" = COLOR_WHITE,
		"design" = COLOR_WHITE,
		"trim" = COLOR_WHITE
	)


	value = 20

/obj/item/clothing/neck/cape/hunter
	polymorphs = list(
		"base" = COLOR_SHALEEZ_RED,
		"design" = COLOR_RED_DARK,
		"trim" = COLOR_SHALEEZ_RED
	)

/obj/item/clothing/neck/cape/hide
	name = "hide cape"
	polymorphs = list(
		"base" = COLOR_BROWN,
		"design" = COLOR_BROWN,
		"trim" = COLOR_BROWN
	)

	defense_rating = list(
		BLADE = 10,
		BLUNT = 10,
		PIERCE = 10,
		COLD = 25
	)

	rarity = RARITY_UNCOMMON

	value = 30

/obj/item/clothing/neck/cape/goliath
	name = "goliath cloak"
	icon = 'icons/obj/items/clothing/suit/goliath_cloak.dmi'
	desc_extended = "A cloak made from goliath hide."

	additional_clothing = list(/obj/item/clothing/head/helmet/)

	defense_rating = list(
		BLADE = 25,
		BLUNT = 25,
		PIERCE = 25,
		LASER = -50,
		MAGIC = 25,
		HEAT = 50,
		COLD = 25
	)

	additional_clothing = list(/obj/item/clothing/head/helmet/attached/goliath_cloak)

	value = 200