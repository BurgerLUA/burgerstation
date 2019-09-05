/obj/item/clothing/feet/shoes/tutorial
	name = "right tutorial boot"
	icon_state = "inventory_right"
	icon_state_worn = "worn_right"

	icon = 'icons/obj/items/clothing/shoes/tutorial_shoes.dmi'

	item_slot = SLOT_FOOT_RIGHT
	protected_limbs = list(BODY_FOOT_RIGHT)

	defense_rating = list(
		BLADE = 10,
		BLUNT = 10,
		PIERCE = 10,
		LASER = 5,
		MAGIC = 25,
		HEAT = 5,
		COLD = 10,
		BOMB = 5,
		BIO = 0,
		RAD = 0,
		HOLY = 0,
		DARK = 50,
		FATIGUE = 0
	)


/obj/item/clothing/feet/shoes/tutorial/left
	name = "left tutorial boot"
	icon_state = "inventory_left"
	icon_state_worn = "worn_left"

	item_slot = SLOT_FOOT_LEFT
	protected_limbs = list(BODY_FOOT_LEFT)

