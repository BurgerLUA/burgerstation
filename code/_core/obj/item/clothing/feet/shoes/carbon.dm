/obj/item/clothing/feet/shoes/carbon_boot
	name = "right carbon boot"
	desc = "For when you REALLY want to turn up the heat."
	desc_extended = "A high-tech boot shielded with carbon-fibre. Somewhat bulky, but protects well."
	rarity = RARITY_RARE
	icon_state = "inventory_right"
	icon_state_worn = "worn_right"
	worn_layer = LAYER_MOB_CLOTHING_BELT

	icon = 'icons/obj/item/clothing/shoes/carbon.dmi'

	item_slot = SLOT_FOOT_RIGHT
	protected_limbs = list(BODY_FOOT_RIGHT)

	defense_rating = list(
		BLADE = AP_CLUB,
		BLUNT = AP_CLUB,
		PIERCE = AP_CLUB,
		LASER = -AP_CLUB,
		ARCANE = -AP_CLUB,
		PAIN = AP_CLUB
	)

	size = SIZE_2


	value = 150

	speed_bonus = 0



/obj/item/clothing/feet/shoes/carbon_boot/left
	name = "left carbon boot"
	icon_state = "inventory_left"
	icon_state_worn = "worn_left"

	item_slot = SLOT_FOOT_LEFT
	protected_limbs = list(BODY_FOOT_LEFT)
	blocks_clothing = SLOT_FOOT_LEFT | SLOT_FOOT_LEFT_U

