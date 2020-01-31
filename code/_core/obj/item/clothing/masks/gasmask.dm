/obj/item/clothing/mask/gas
	name = "gas mask"
	icon = 'obj/items/clothing/masks/gasmask.dmi'
	flags_clothing = FLAG_CLOTHING_NOBEAST_HEAD
	desc = "Oxygen not included."
	desc_extended = "A modern gas mask. Filters out most forms of gas."
	rarity = RARITY_UNCOMMON

	defense_rating = list(
		BLADE = ARMOR_D,
		BLUNT = ARMOR_E,
		PIERCE = ARMOR_D,
		HEAT = ARMOR_E,
		COLD = ARMOR_E,
		BOMB = ARMOR_E,
		BIO = ARMOR_S,
		RAD = ARMOR_D
	)

	size = SIZE_2
	weight = WEIGHT_2


/obj/item/clothing/mask/gas/clown
	name = "clown mask"
	icon = 'obj/items/clothing/masks/clown.dmi'
	desc = "Where the clown gets their power."
	desc_extended = "A flawless clown mask and wig."

	defense_rating = list(
		MAGIC = ARMOR_A,
		HOLY = ARMOR_C,
		DARK = ARMOR_C
	)

	size = SIZE_2
	weight = WEIGHT_1


/obj/item/clothing/mask/gas/mining
	name = "advanced gas mask"
	icon = 'obj/items/clothing/masks/mining.dmi'
	flags_clothing = FLAG_CLOTHING_NOBEAST_HEAD
	desc = "Oxygen not included."
	desc_extended = "An advanced gas mask. Filters out most forms of gas."
	rarity = RARITY_RARE

	defense_rating = list(
		BLADE = ARMOR_C,
		BLUNT = ARMOR_D,
		PIERCE = ARMOR_D,
		HEAT = ARMOR_B,
		COLD = ARMOR_E,
		BOMB = ARMOR_E,
		BIO = ARMOR_S,
		RAD = ARMOR_C
	)

	size = SIZE_2
	weight = WEIGHT_3