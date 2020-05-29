/obj/item/clothing/head/helmet/hardsuit/

	hidden_organs = list(
		BODY_HEAD = TRUE,
		BODY_HAIR_HEAD = TRUE,
		BODY_HAIR_FACE = TRUE,
		BODY_EYES = TRUE
	)


/obj/item/clothing/head/helmet/hardsuit/engineering
	name = "engineering rig helmet"
	icon = 'icons/obj/items/clothing/hats/engineering_rig_helmet.dmi'
	rarity = RARITY_UNCOMMON

	defense_rating = list(
		BLADE = 25,
		BLUNT = 50,
		PIERCE = 25,
		LASER = 10,
		MAGIC = -75,
		HEAT = 0,
		COLD = 0,
		BOMB = 0,
		BIO = 0,
		RAD = 0,
		HOLY = 0,
		DARK = 0,
		FATIGUE = 0
	)

	size = SIZE_3
	weight = WEIGHT_4

	value = 80


/obj/item/clothing/head/helmet/hardsuit/syndie
	name = "mauler helmet mk1"
	icon = 'icons/obj/items/clothing/hats/syndie_basic.dmi'
	rarity = RARITY_UNCOMMON

	defense_rating = list(
		BLADE = 50,
		BLUNT = 25,
		PIERCE = 50,
		LASER = 25,
		MAGIC = -50,
		HEAT = 75,
		COLD = 75,
		BOMB = 25,
		BIO = 50,
		RAD = 25
	)

	size = SIZE_4
	weight = WEIGHT_5

	value = 50

/obj/item/clothing/head/helmet/hardsuit/syndie/advanced
	name = "mauler helmet mk2"
	icon = 'icons/obj/items/clothing/hats/syndie_advanced.dmi'
	rarity = RARITY_RARE

	defense_rating = list(
		BLADE = 50,
		BLUNT = 50,
		PIERCE = 50,
		LASER = 25,
		MAGIC = -50,
		HEAT = 75,
		COLD = 75,
		BOMB = 25,
		BIO = 75,
		RAD = 50
	)

	size = SIZE_3
	weight = WEIGHT_4

	value = 80

/obj/item/clothing/head/helmet/hardsuit/syndie/elite
	name = "mauler helmet mk3"
	icon = 'icons/obj/items/clothing/hats/syndie_elite.dmi'
	rarity = RARITY_MYTHICAL

	defense_rating = list(
		BLADE = 75,
		BLUNT = 50,
		PIERCE = 75,
		LASER = 50,
		MAGIC = -75,
		HEAT = 75,
		COLD = 75,
		BOMB = 50,
		BIO = 75,
		RAD = 50
	)

	size = SIZE_3
	weight = WEIGHT_4

	slowdown_mul_worn = 0.75

	value = 150

/obj/item/clothing/head/helmet/hardsuit/mining
	name = "mining hardsuit helmet"
	icon = 'icons/obj/items/clothing/hats/hardsuit_mining.dmi'
	rarity = RARITY_UNCOMMON

	defense_rating = list(

	)

	size = SIZE_3
	weight = WEIGHT_4

	value = 40