/obj/item/clothing/feet/shoes/colored
	name = "right shoe"
	icon_state = "inventory_right"
	icon_state_worn = "worn_right"

	icon = 'icons/obj/items/clothing/shoes/colored.dmi'

	item_slot = SLOT_FOOT_RIGHT
	protected_limbs = list(BODY_FOOT_RIGHT)

	no_initial_blend = TRUE

	defense_rating = list(
		BLADE = ARMOR_D,
		BLUNT = ARMOR_E,
		PIERCE = ARMOR_D,
		MAGIC = ARMOR_C,
		HEAT = ARMOR_D,
		COLD = ARMOR_D
	)

	size = SIZE_1
	weight = WEIGHT_1



	polymorphs = list(
		"base" = COLOR_WHITE,
		"ankle" = COLOR_WHITE,
		"sole" = COLOR_GREY_LIGHT
	)

	value = 10

	slowdown_mul_worn = 0.95

/obj/item/clothing/feet/shoes/colored/left
	name = "left shoe"
	icon_state = "inventory_left"
	icon_state_worn = "worn_left"

	item_slot = SLOT_FOOT_LEFT
	protected_limbs = list(BODY_FOOT_LEFT)


/obj/item/clothing/feet/shoes/colored/black
	polymorphs = list(
		"base" = COLOR_WHITE,
		"ankle" = COLOR_BLACK,
		"sole" = COLOR_GREY_LIGHT
	)


/obj/item/clothing/feet/shoes/colored/black/left
	name = "left shoe"
	icon_state = "inventory_left"
	icon_state_worn = "worn_left"

	item_slot = SLOT_FOOT_LEFT
	protected_limbs = list(BODY_FOOT_LEFT)

/obj/item/clothing/feet/shoes/colored/blacker
	polymorphs = list(
		"base" = COLOR_BLACK,
		"ankle" = COLOR_BLACK,
		"sole" = COLOR_GREY_LIGHT
	)

/obj/item/clothing/feet/shoes/colored/blacker/left
	name = "left shoe"
	icon_state = "inventory_left"
	icon_state_worn = "worn_left"

	item_slot = SLOT_FOOT_LEFT
	protected_limbs = list(BODY_FOOT_LEFT)


/obj/item/clothing/feet/shoes/colored/brown
	polymorphs = list(
		"base" = COLOR_BROWN_LIGHT,
		"ankle" = COLOR_BROWN_LIGHT,
		"sole" = COLOR_BROWN
	)

/obj/item/clothing/feet/shoes/colored/brown/left
	name = "left shoe"
	icon_state = "inventory_left"
	icon_state_worn = "worn_left"

	item_slot = SLOT_FOOT_LEFT
	protected_limbs = list(BODY_FOOT_LEFT)
