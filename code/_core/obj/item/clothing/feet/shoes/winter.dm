/obj/item/clothing/feet/shoes/winter
	name = "right winter boot"
	icon_state = "inventory_right"
	icon_state_worn = "worn_right"
	worn_layer = LAYER_MOB_CLOTHING_BELT

	icon = 'icons/obj/item/clothing/shoes/winter.dmi'

	item_slot = SLOT_FOOT_RIGHT
	protected_limbs = list(BODY_FOOT_RIGHT)

	defense_rating = list(
		BLADE = AP_SWORD,
		BLUNT = AP_SWORD,
		PIERCE = AP_SWORD,
		LASER = -AP_SWORD,
		ARCANE = -AP_SWORD,
		HEAT = -AP_SWORD,
		COLD = AP_CLUB
	)

	protection_cold = list(
		BODY_FOOT_RIGHT = 3,
		BODY_LEG_RIGHT = 1
	)

	size = SIZE_2


	value = 70



/obj/item/clothing/feet/shoes/winter/left
	name = "left winter boot"
	icon_state = "inventory_left"
	icon_state_worn = "worn_left"

	item_slot = SLOT_FOOT_LEFT
	protected_limbs = list(BODY_FOOT_LEFT)
	blocks_clothing = SLOT_FOOT_LEFT | SLOT_FOOT_LEFT_U

	protection_cold = list(
		BODY_FOOT_LEFT = 3,
		BODY_LEG_LEFT = 1
	)
