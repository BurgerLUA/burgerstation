/obj/item/clothing/feet/shoes/magboot
	name = "right magboot"
	desc = "Water-proof."
	desc_extended = "Heavy boots with a magnetic sole. Prevents you from losing grip and floating off into the void."
	rarity = RARITY_UNCOMMON
	icon_state = "inventory_right"
	icon_state_worn = "worn_right"
	worn_layer = LAYER_MOB_CLOTHING_BELT

	icon = 'icons/obj/item/clothing/shoes/magboots.dmi'

	item_slot = SLOT_FOOT
	item_slot_mod = SLOT_MOD_LEFT
	protected_limbs = list(BODY_FOOT_RIGHT)

	defense_rating = list(
		BLADE = 20,
		BLUNT = 60,
		PIERCE = 40,
		ARCANE = -60,
		HEAT = 60,
		COLD = 60,
		FATIGUE = 60,
		PAIN = 120
	)

	size = SIZE_2

	value = 200

	speed_bonus = -0.2

	item_slot_layer = 3

/obj/item/clothing/feet/shoes/magboot/left
	name = "left magboot"
	icon_state = "inventory_left"
	icon_state_worn = "worn_left"

	item_slot = SLOT_FOOT
	item_slot_mod = SLOT_MOD_LEFT
	protected_limbs = list(BODY_FOOT_LEFT)



