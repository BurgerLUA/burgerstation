/obj/item/clothing/feet/shoes/engineering
	name = "right engineering boot"
	desc = "Magboots not included."
	desc_extended = "Part of the engineering rigsuit. Don't lose them!"
	rarity = RARITY_RARE
	icon_state = "inventory_right"
	icon_state_worn = "worn_right"
	worn_layer = LAYER_MOB_CLOTHING_BELT

	icon = 'icons/obj/item/clothing/shoes/engineering_rig_boots.dmi'

	item_slot = SLOT_FOOT_RIGHT_O
	protected_limbs = list(BODY_FOOT_RIGHT)

	defense_rating = list(
		BLADE = 25,
		BLUNT = 50,
		PIERCE = 25,
		LASER = 25,
		ARCANE = -75,
		HEAT = 100,
		COLD = 100,
		BOMB = 25,
		BIO = 25,
		RAD = 75
	)

	size = SIZE_2

	value = 300

	slowdown_mul_worn = 1.05

/obj/item/clothing/feet/shoes/engineering/left
	name = "left engineering boot"
	icon_state = "inventory_left"
	icon_state_worn = "worn_left"

	item_slot = SLOT_FOOT_LEFT_O
	protected_limbs = list(BODY_FOOT_LEFT)
	blocks_clothing = SLOT_FOOT_LEFT_U

