/obj/item/clothing/feet/shoes/magboot
	name = "right magboot"
	desc = "Water-proof."
	desc_extended = "Heavy boots with a magnetic sole. Prevents you from losing grip and floating off into the void."
	rarity = RARITY_UNCOMMON
	icon_state = "inventory_right"
	icon_state_worn = "worn_right"
	worn_layer = LAYER_MOB_CLOTHING_BELT

	icon = 'icons/obj/item/clothing/shoes/magboots.dmi'

	item_slot = SLOT_FOOT_RIGHT_O
	protected_limbs = list(BODY_FOOT_RIGHT)

	defense_rating = list(
		BLADE = AP_SWORD,
		BLUNT = AP_CLUB,
		PIERCE = AP_AXE,
		ARCANE = -AP_CLUB,
		HEAT = AP_CLUB,
		COLD = AP_CLUB,
		FATIGUE = AP_CLUB,
		PAIN = AP_GREATCLUB
	)

	size = SIZE_2

	value = 200

	speed_bonus = -0.2

/obj/item/clothing/feet/shoes/magboot/left
	name = "left magboot"
	icon_state = "inventory_left"
	icon_state_worn = "worn_left"

	item_slot = SLOT_FOOT_LEFT_O
	protected_limbs = list(BODY_FOOT_LEFT)
	blocks_clothing = SLOT_FOOT_LEFT | SLOT_FOOT_LEFT_U



