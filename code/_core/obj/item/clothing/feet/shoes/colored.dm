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

	polymorphic = TRUE

	color_primary = "#FFFFFF"
	color_secondary = "#FFFFFF"
	color_tertiary = "#FFFFFF"

	color_primary_desc = "shirt"
	color_secondary_desc = "pants"
	color_tertiary_desc = "shoulders"

/obj/item/clothing/feet/shoes/colored/left
	name = "left shoe"
	icon_state = "inventory_left"
	icon_state_worn = "worn_left"

	item_slot = SLOT_FOOT_LEFT
	protected_limbs = list(BODY_FOOT_LEFT)