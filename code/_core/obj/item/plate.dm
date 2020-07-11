/obj/item/armor_plate
	name = "armor plate"
	desc = "Not for eating food off of."
	desc_extended = "A protective armor plate designed to fit a plate carrier."
	icon = 'icons/obj/item/plate.dmi'
	icon_state = "light"

	var/list/armor_base = list()

/obj/item/armor_plate/light
	name = "light armor plate"
	icon_state = "light"
	armor_base = list(
		BLADE = 25,
		BLUNT = 25,
		PIERCE = 25,
		LASER = 10,
		MAGIC = -25
	)
	weight = WEIGHT_3

/obj/item/armor_plate/medium
	name = "medium armor plate"
	icon_state = "medium"
	armor_base = list(
		BLADE = 25,
		BLUNT = 50,
		PIERCE = 50,
		LASER = 25,
		MAGIC = -50
	)
	weight = WEIGHT_4


/obj/item/armor_plate/heavy
	name = "heavy armor plate"
	armor_base = list(
		BLADE = 25,
		BLUNT = 75,
		PIERCE = 75,
		LASER = 25,
		MAGIC = -75
	)
	weight = WEIGHT_5

/obj/item/armor_plate/super
	name = "super armor plate"
	armor_base = list(
		BLADE = 25,
		BLUNT = 75,
		PIERCE = 75,
		LASER = 25,
		MAGIC = -75
	)
	weight = WEIGHT_6