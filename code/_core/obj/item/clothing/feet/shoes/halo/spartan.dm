/obj/item/clothing/feet/shoes/halo/spartan
	name = "MJOLNIR Mark V right Leg Armour"
	desc = "For when you REALLY want to turn up the heat."
	desc_extended = "Leg armour, to be used with the Sangheili Combat Harness."
	rarity = RARITY_RARE
	icon_state = "inventory_right"
	icon_state_worn = "worn_right"
	worn_layer = LAYER_MOB_CLOTHING_BELT

	icon = 'icons/obj/item/clothing/shoes/spartan.dmi'

	flags_clothing = FLAG_CLOTHING_SPARTAN
	item_slot = SLOT_FOOT_RIGHT
	protected_limbs = list(BODY_FOOT_RIGHT)

	defense_rating = list(
		BLADE = AP_AXE,
		BLUNT = AP_AXE,
		PIERCE = AP_AXE,
		LASER = AP_AXE,
		ARCANE = -AP_AXE,
		COLD = -AP_AXE,
		BOMB = AP_AXE,
		PAIN = AP_AXE
	)

	size = SIZE_2


	value = 150

	speed_bonus = 0


/obj/item/clothing/feet/shoes/halo/spartan/left
	name = "MJOLNIR Mark V left Leg Armour"
	icon_state = "inventory_left"
	icon_state_worn = "worn_left"

	item_slot = SLOT_FOOT_LEFT
	protected_limbs = list(BODY_FOOT_LEFT)
	blocks_clothing = SLOT_FOOT_LEFT | SLOT_FOOT_LEFT_U