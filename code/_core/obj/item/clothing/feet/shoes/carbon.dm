/obj/item/clothing/feet/shoes/carbon_boot
	name = "right carbon boot"
	rarity = RARITY_RARE
	icon_state = "inventory_right"
	icon_state_worn = "worn_right"
	worn_layer = LAYER_MOB_CLOTHING_BELT

	icon = 'icons/obj/items/clothing/shoes/carbon.dmi'

	item_slot = SLOT_FOOT_RIGHT
	protected_limbs = list(BODY_FOOT_RIGHT)

	defense_rating = list(
		BLADE = 25,
		BLUNT = 50,
		PIERCE = 50,
		LASER = -50,
		MAGIC = -50,
		BOMB = 75
	)

	size = SIZE_2
	weight = WEIGHT_2

	value = 80

	slowdown_mul_worn = 1.1

/obj/item/clothing/feet/shoes/carbon_boot/left
	name = "left carbon boot"
	icon_state = "inventory_left"
	icon_state_worn = "worn_left"

	item_slot = SLOT_FOOT_LEFT
	protected_limbs = list(BODY_FOOT_LEFT)
	blocks_clothing = SLOT_FOOT_LEFT_U

