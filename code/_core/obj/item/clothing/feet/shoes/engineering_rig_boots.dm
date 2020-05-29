/obj/item/clothing/feet/shoes/engineering
	name = "right engineering boot"
	rarity = RARITY_RARE
	icon_state = "inventory_right"
	icon_state_worn = "worn_right"
	worn_layer = LAYER_MOB_CLOTHING_BELT

	icon = 'icons/obj/items/clothing/shoes/engineering_rig_boots.dmi'

	item_slot = SLOT_FOOT_RIGHT_O
	protected_limbs = list(BODY_FOOT_RIGHT)

	defense_rating = list(
		BLADE = 20,
		BLUNT = 50,
		PIERCE = 20,
		LASER = 25,
		MAGIC = -75,
		HEAT = 75,
		COLD = 75,
		BOMB = 10,
		BIO = 50,
		RAD = 75
	)

	size = SIZE_2
	weight = WEIGHT_2

	value = 100

	slowdown_mul_worn = 1.05

/obj/item/clothing/feet/shoes/engineering/left
	name = "left engineering boot"
	icon_state = "inventory_left"
	icon_state_worn = "worn_left"

	item_slot = SLOT_FOOT_LEFT_O
	protected_limbs = list(BODY_FOOT_LEFT)
	blocks_clothing = SLOT_FOOT_LEFT_U

