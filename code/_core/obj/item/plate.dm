/obj/item/armor_plate
	name = "armor plate"
	desc = "Not for eating food off of."
	desc_extended = "A protective armor plate designed to fit a plate carrier."
	icon = 'icons/obj/item/plate.dmi'
	icon_state = "light"

	var/list/armor_base = list()

	size = SIZE_2

	slowdown_mul_worn = 1


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


	value = 90

	slowdown_mul_worn = 1.1

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


	value = 190

	slowdown_mul_worn = 1.15


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

	slowdown_mul_worn = 1.2



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

	slowdown_mul_worn = 1.3

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

	slowdown_mul_worn = 1.3

	value = 1000