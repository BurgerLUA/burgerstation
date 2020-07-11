/obj/item/armor_plate
	name = "armor plate"
	desc = "Not for eating food off of."
	desc_extended = "A protective armor plate designed to fit a plate carrier."
	icon = 'icons/obj/item/plate.dmi'
	icon_state = "light"

	var/list/armor_base = list()

	size = SIZE_2
	weight = WEIGHT_3

/obj/item/armor_plate/light
	name = "light armor plate"
	icon_state = "light"
	rarity = RARITY_COMMON
	armor_base = list(
		BLADE = 15,
		BLUNT = 15,
		PIERCE = 15,
		LASER = 10,
		MAGIC = -20
	)
	weight = WEIGHT_3

	value = 90

/obj/item/armor_plate/medium
	name = "medium armor plate"
	icon_state = "medium"
	rarity = RARITY_COMMON
	armor_base = list(
		BLADE = 15,
		BLUNT = 30,
		PIERCE = 30,
		LASER = 10,
		MAGIC = -40
	)
	weight = WEIGHT_4

	value = 190

/obj/item/armor_plate/heavy
	name = "heavy armor plate"
	icon_state = "heavy"
	rarity = RARITY_UNCOMMON
	armor_base = list(
		BLADE = 15,
		BLUNT = 45,
		PIERCE = 45,
		LASER = 25,
		MAGIC = -60
	)
	weight = WEIGHT_5

	value = 275

/obj/item/armor_plate/super
	name = "super armor plate"
	icon_state = "super"
	rarity = RARITY_RARE
	armor_base = list(
		BLADE = 25,
		BLUNT = 65,
		PIERCE = 65,
		LASER = 25,
		MAGIC = -75
	)
	weight = WEIGHT_6

	value = 500

/obj/item/armor_plate/ultra
	name = "ultra armor plate"
	icon_state = "super"
	rarity = RARITY_MYTHICAL
	armor_base = list(
		BLADE = 50,
		BLUNT = 75,
		PIERCE = 75,
		LASER = 50,
		MAGIC = -100
	)
	weight = WEIGHT_6

	value = 1000