/obj/item/clothing/shirt/blouse
	name = "blouse"
	icon = 'icons/obj/items/clothing/shirts/blouse.dmi'

	item_slot = SLOT_TORSO

	defense_rating = list(
		BLADE = 15,
		BLUNT = 15,
		PIERCE = 15,
		MAGIC = 10,
		COLD = 25,
	)

	polymorphs = list(
		"blouse" = COLOR_WHITE
	)

	value = 20


/obj/item/clothing/shirt/blouse/frill
	name = "striped blouse"
	polymorphs = list(
		"blouse" = COLOR_GREY,
		"frill" = COLOR_WHITE
	)

/obj/item/clothing/shirt/blouse/uniform
	name = "uniformed blouse"
	polymorphs = list(
		"blouse" = COLOR_WHITE,
		"shoulders" = COLOR_BLACK
	)