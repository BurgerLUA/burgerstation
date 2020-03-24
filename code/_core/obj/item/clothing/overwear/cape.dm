/obj/item/clothing/neck/cape
	name = "cape"
	icon = 'icons/obj/items/clothing/suit/cape.dmi'


	protected_limbs = list(BODY_TORSO)

	defense_rating = list(
		MAGIC = ARMOR_C,
		COLD = ARMOR_C
	)

	rarity = RARITY_UNCOMMON

	size = SIZE_2
	weight = WEIGHT_2

	worn_layer = LAYER_MOB_CLOTHING_NECK_OVER

	polymorphs = list(
		"base" = COLOR_WHITE,
		"design" = COLOR_WHITE,
		"trim" = COLOR_WHITE
	)


	value = 20

/obj/item/clothing/neck/cape/hunter
	name = "hunter's cape"

	polymorphs = list(
		"base" = COLOR_SHALEEZ_RED,
		"design" = COLOR_RED_DARK,
		"trim" = COLOR_SHALEEZ_RED
	)

	defense_rating = list(
		BLADE = ARMOR_D,
		BLUNT = ARMOR_D,
		PIERCE = ARMOR_D,
		MAGIC = ARMOR_E,
		COLD = ARMOR_C,
		DARK = ARMOR_C
	)

	rarity = RARITY_MYTHICAL

	value = 40

/obj/item/clothing/neck/cape/hide
	name = "hide cape"
	polymorphs = list(
		"base" = COLOR_BROWN,
		"design" = COLOR_BROWN,
		"trim" = COLOR_BROWN
	)

	defense_rating = list(
		BLADE = ARMOR_D,
		BLUNT = ARMOR_E,
		PIERCE = ARMOR_D,
		MAGIC = ARMOR_D,
		COLD = ARMOR_C
	)

	rarity = RARITY_UNCOMMON

	value = 30

