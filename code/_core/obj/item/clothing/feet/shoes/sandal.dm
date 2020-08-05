/obj/item/clothing/feet/shoes/sandal
	name = "right sandal"
	desc = "DO NOT WEAR WITH SOCKS UNDER ANY CIRCUMSTANCES."
	desc_extended = "Also increases strength of magic spells."
	rarity = RARITY_COMMON
	icon_state = "inventory_right"
	icon_state_worn = "worn_right"

	icon = 'icons/obj/item/clothing/shoes/sandal.dmi'

	item_slot = SLOT_FOOT_RIGHT
	protected_limbs = list(BODY_FOOT_RIGHT)

	defense_rating = list(
		ARCANE = 75
	)

	size = SIZE_1


	value = 20

	slowdown_mul_worn = 1

/obj/item/clothing/feet/shoes/sandal/left
	name = "left sandal"
	icon_state = "inventory_left"
	icon_state_worn = "worn_left"

	item_slot = SLOT_FOOT_LEFT
	protected_limbs = list(BODY_FOOT_LEFT)
	blocks_clothing = SLOT_FOOT_LEFT_U