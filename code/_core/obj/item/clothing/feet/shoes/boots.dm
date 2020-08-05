/obj/item/clothing/feet/shoes/black_boots
	name = "right black boot"
	desc = "For when you want to turn up the heat a little."
	desc_extended = "A black combat boot. Shields your feet from shrapnel."
	rarity = RARITY_UNCOMMON
	icon_state = "inventory_right"
	icon_state_worn = "worn_right"
	worn_layer = LAYER_MOB_CLOTHING_BELT

	icon = 'icons/obj/item/clothing/shoes/boots.dmi'

	item_slot = SLOT_FOOT_RIGHT
	protected_limbs = list(BODY_FOOT_RIGHT)

	defense_rating = list(
		BLADE = 25,
		BLUNT = 25,
		PIERCE = 25,
		LASER = -10,
		ARCANE = -25,
		COLD = 25,
		BOMB = 10
	)

	size = SIZE_2


	value = 60

	slowdown_mul_worn = 1

/obj/item/clothing/feet/shoes/black_boots/left
	name = "left black boot"
	icon_state = "inventory_left"
	icon_state_worn = "worn_left"

	item_slot = SLOT_FOOT_LEFT
	protected_limbs = list(BODY_FOOT_LEFT)
	blocks_clothing = SLOT_FOOT_LEFT_U

