/obj/item/clothing/overwear/armor/medium_armor/leather
	name = "medium leather armor"
	desc = "This is medieval, right?"
	desc_extended = "A suit of leather armor. Often seeing at renessaince faires, despite the fact medieval soldiers wore wool gambesons."
	color = "#8C4438"

	defense_rating = list(
		BLADE = 25,
		BLUNT = 25,
		PIERCE = 25,
		COLD = 25
	)

	size = SIZE_4
	weight = WEIGHT_4

	value = 30

	dyeable = TRUE

/obj/item/clothing/overwear/armor/medium_armor/security
	name = "padded kevlar security armor"
	color = COLOR_BLACK

	defense_rating = list(
		BLADE = 25,
		BLUNT = 25,
		PIERCE = 50,
		MAGIC = -50,
		COLD = 15
	)

	size = SIZE_4
	weight = WEIGHT_5

	value = 50