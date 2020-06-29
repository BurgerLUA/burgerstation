/obj/item/clothing/head/helmet/hardsuit/

	hidden_organs = list(
		BODY_HEAD = TRUE,
		BODY_HAIR_HEAD = TRUE,
		BODY_HAIR_FACE = TRUE,
		BODY_EYES = TRUE
	)


/obj/item/clothing/head/helmet/hardsuit/engineering
	name = "engineering rig helmet"
	icon = 'icons/obj/item/clothing/hats/engineering_rig_helmet.dmi'
	rarity = RARITY_UNCOMMON

	defense_rating = list(
		BLADE = 50,
		BLUNT = 50,
		PIERCE = 50,
		LASER = 50,
		MAGIC = -100,
		HEAT = 75,
		COLD = 100,
		BOMB = 25,
		BIO = 75,
		RAD = 75
	)

	size = SIZE_3
	weight = WEIGHT_4

	value = 80


/obj/item/clothing/head/helmet/hardsuit/syndie
	name = "mauler helmet mk1"
	icon = 'icons/obj/item/clothing/hats/syndie_basic.dmi'
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

	size = SIZE_4
	weight = WEIGHT_5

	value = 200

/obj/item/clothing/head/helmet/hardsuit/syndie/advanced
	name = "mauler helmet mk2"
	icon = 'icons/obj/item/clothing/hats/syndie_advanced.dmi'
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

	size = SIZE_3
	weight = WEIGHT_4

	value = 300

/obj/item/clothing/head/helmet/hardsuit/syndie/elite
	name = "mauler helmet mk3"
	icon = 'icons/obj/item/clothing/hats/syndie_elite.dmi'
	rarity = RARITY_MYTHICAL

	defense_rating = list(
		BLADE = 25,
		BLUNT = 100,
		PIERCE = 100,
		LASER = 50,
		MAGIC = -100,
		HEAT = 75,
		COLD = 75,
		BOMB = 75,
		BIO = 75,
		RAD = 25
	)

	size = SIZE_3
	weight = WEIGHT_4

	slowdown_mul_worn = 0.75

	value = 500

/obj/item/clothing/head/helmet/hardsuit/mining
	name = "mining hardsuit helmet"
	icon = 'icons/obj/item/clothing/hats/hardsuit_mining.dmi'
	rarity = RARITY_UNCOMMON

	defense_rating = list(
		BLADE = 75,
		BLUNT = 50,
		PIERCE = 50,
		LASER = 25,
		MAGIC = -50,
		HEAT = 100,
		COLD = 75,
		BOMB = 25,
		BIO = 75,
		RAD = 75
	)

	size = SIZE_3
	weight = WEIGHT_4

	value = 300