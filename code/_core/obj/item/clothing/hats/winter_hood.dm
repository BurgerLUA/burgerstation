/obj/item/clothing/head/hood/winter
	name = "winter hood"
	icon = 'icons/obj/items/clothing/hats/winter_hood.dmi'

	hidden_organs = list(
		BODY_HAIR_HEAD = TRUE
	)

	defense_rating = list(
		LASER = -25,
		MAGIC = 50,
		HEAT = -25,
		COLD = 75
	)

	protection_cold = list(
		BODY_HEAD = 5,
	)

	size = SIZE_2
	weight = WEIGHT_1

	value = 10


/obj/item/clothing/head/hood/hoodie
	name = "hoodie hood"
	icon = 'icons/obj/items/clothing/hats/hoodie.dmi'

	size = SIZE_2
	weight = WEIGHT_1

	dyeable = FALSE

	value = 10

	defense_rating = list(
		MAGIC = 50,
		HEAT = -25,
		COLD = 50
	)

	hidden_organs = list(
		BODY_HAIR_HEAD = TRUE
	)