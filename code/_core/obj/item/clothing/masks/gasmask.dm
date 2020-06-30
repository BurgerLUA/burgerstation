/obj/item/clothing/mask/gas
	name = "gas mask"
	icon = 'obj/item/clothing/masks/gasmask.dmi'
	flags_clothing = FLAG_CLOTHING_NOBEAST_HEAD
	desc = "Oxygen not included."
	desc_extended = "A modern gas mask. Filters out most forms of gas."
	rarity = RARITY_UNCOMMON

	defense_rating = list(
		BLADE = 10,
		BLUNT = 10,
		PIERCE = 10,
		BIO = 90,
		RAD = 10
	)

	size = SIZE_2
	weight = WEIGHT_2

	value = 40


/obj/item/clothing/mask/gas/clown
	name = "clown mask"
	icon = 'obj/item/clothing/masks/clown.dmi'
	desc = "Where the clown gets their power."
	desc_extended = "A flawless clown mask and wig."

	defense_rating = list(
		BLADE = 10,
		BLUNT = 10,
		PIERCE = 10,
		BIO = 50,
		RAD = 10,
		HOLY = -50,
		DARK = 50
	)

	size = SIZE_2
	weight = WEIGHT_1

	value = 100


/obj/item/clothing/mask/gas/mining
	name = "advanced gas mask"
	icon = 'obj/item/clothing/masks/mining.dmi'
	flags_clothing = FLAG_CLOTHING_NOBEAST_HEAD
	desc = "Oxygen not included."
	desc_extended = "An advanced gas mask. Filters out most forms of gas."
	rarity = RARITY_RARE

	defense_rating = list(
		BLADE = 25,
		BLUNT = 25,
		PIERCE = 25,
		MAGIC = -25,
		HEAT = 50,
		BIO = 90
	)

	size = SIZE_2
	weight = WEIGHT_3

	value = 50