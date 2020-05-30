/obj/item/clothing/overwear/hardsuit/syndie
	name = "mauler hardsuit mk1"
	icon = 'icons/obj/items/clothing/suit/syndie_basic.dmi'
	rarity = RARITY_UNCOMMON

	defense_rating = list(
		BLADE = 50,
		BLUNT = 50,
		PIERCE = 50,
		LASER = 25,
		MAGIC = -100,
		HEAT = 75,
		COLD = 75,
		BOMB = 75,
		BIO = 75,
		RAD = 25
	)

	size = SIZE_7
	weight = WEIGHT_7

	additional_clothing = list(/obj/item/clothing/head/helmet/hardsuit/syndie)

	slowdown_mul_worn = 1.2

	value = 120

/obj/item/clothing/overwear/hardsuit/syndie/advanced
	name = "mauler hardsuit mk2"
	icon = 'icons/obj/items/clothing/suit/syndie_advanced.dmi'
	rarity = RARITY_RARE

	defense_rating = list(
		BLADE = 50,
		BLUNT = 75,
		PIERCE = 75,
		LASER = 25,
		MAGIC = -100,
		HEAT = 75,
		COLD = 75,
		BOMB = 75,
		BIO = 75,
		RAD = 25
	)

	size = SIZE_6
	weight = WEIGHT_6

	additional_clothing = list(/obj/item/clothing/head/helmet/hardsuit/syndie/advanced)

	slowdown_mul_worn = 1.2

	value = 180

/obj/item/clothing/overwear/hardsuit/syndie/elite
	name = "mauler hardsuit mk3"
	icon = 'icons/obj/items/clothing/suit/syndie_elite.dmi'
	rarity = RARITY_MYTHICAL

	defense_rating = list(
		BLADE = 25,
		BLUNT = 75,
		PIERCE = 75,
		LASER = 50,
		MAGIC = -100,
		HEAT = 75,
		COLD = 75,
		BOMB = 75,
		BIO = 75,
		RAD = 25
	)

	additional_clothing = list(/obj/item/clothing/head/helmet/hardsuit/syndie/elite)

	size = SIZE_6
	weight = WEIGHT_5
	slowdown_mul_worn = 1

	value = 360