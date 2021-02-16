/obj/item/clothing/feet/shoes/plascrusaderboots
	name = "right plascrusader boot"
	desc = "When you gotta walk around in style."
	desc_extended = "A fine looking gold metal boot made from high quality metals."
	rarity = RARITY_RARE
	icon_state = "inventory_right"
	icon_state_worn = "worn_right"
	worn_layer = LAYER_MOB_CLOTHING_BELT

	icon = 'icons/obj/item/clothing/shoes/plascrusaderboots.dmi'

	item_slot = SLOT_FOOT_RIGHT
	protected_limbs = list(BODY_FOOT_RIGHT,BODY_LEG_RIGHT)

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



/obj/item/clothing/feet/shoes/plascrusaderboots/left
	name = "left plascrusader boot"
	icon_state = "inventory_left"
	icon_state_worn = "worn_left"

	item_slot = SLOT_FOOT_LEFT
	protected_limbs = list(BODY_FOOT_LEFT,BODY_LEG_LEFT)
	blocks_clothing = SLOT_FOOT_LEFT | SLOT_FOOT_LEFT_U

