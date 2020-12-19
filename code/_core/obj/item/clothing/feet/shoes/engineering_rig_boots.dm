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
		BLADE = AP_SWORD,
		BLUNT = AP_CLUB,
		PIERCE = AP_AXE,
		ARCANE = -AP_CLUB,
		HEAT = AP_CLUB,
		COLD = AP_CLUB,
		RAD = AP_CLUB,
		FATIGUE = AP_CLUB,
		PAIN = AP_GREATCLUB
	)

	size = SIZE_2

	value = 300

	speed_bonus = -0.1



/obj/item/clothing/feet/shoes/engineering/left
	name = "left engineering boot"
	icon_state = "inventory_left"
	icon_state_worn = "worn_left"

	item_slot = SLOT_FOOT_LEFT_O
	protected_limbs = list(BODY_FOOT_LEFT)
	blocks_clothing = SLOT_FOOT_LEFT | SLOT_FOOT_LEFT_U

