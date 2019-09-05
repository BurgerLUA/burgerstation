/obj/item/clothing/mask/gas
	name = "gas mask"
	icon = 'obj/items/clothing/masks/gasmask.dmi'
	flags_clothing = FLAG_CLOTHING_NOBEAST_HEAD
	desc = "Oxygen not included."
	desc_extended = "A modern gas mask. Filters out most forms of gas."

	defense_rating = list(
		BLADE = 5,
		BLUNT = 5,
		PIERCE = 5,
		LASER = 0,
		MAGIC = 0,
		HEAT = 10,
		COLD = 10,
		BOMB = 5,
		BIO = 300,
		RAD = 25,
		HOLY = 0,
		DARK = 0,
		FATIGUE = 0
	)


/obj/item/clothing/mask/gas/clown
	name = "clown mask"
	icon = 'obj/items/clothing/masks/clown.dmi'
	desc = "Where the clown gets their power."
	desc_extended = "A flawless clown mask and wig."

	defense_rating = list(
		BLADE = 0,
		BLUNT = 0,
		PIERCE = 0,
		LASER = 0,
		MAGIC = 50,
		HEAT = 0,
		COLD = 0,
		BOMB = 0,
		BIO = 50,
		RAD = 10,
		HOLY = 25,
		DARK = 25,
		FATIGUE = 100
	)