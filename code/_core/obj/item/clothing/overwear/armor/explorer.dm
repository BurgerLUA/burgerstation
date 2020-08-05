/obj/item/clothing/overwear/armor/explorer_suit
	name = "explorer's suit"
	desc = "CARGO WE NEED DIAMONDS"
	desc_extended = "A protective suit of armor worn by miners to protect from the megafauna. Also comes with a hood and gas mask that can be brought up by shift-clicking the suit."
	icon = 'icons/obj/item/clothing/suit/explorer_suit.dmi'
	item_slot = SLOT_TORSO_A | SLOT_TORSO_O
	worn_layer = LAYER_MOB_CLOTHING_HARDSUIT
	rarity = RARITY_UNCOMMON

	protected_limbs = list(BODY_TORSO,BODY_GROIN,BODY_ARM_LEFT,BODY_ARM_RIGHT,BODY_HAND_LEFT,BODY_HAND_RIGHT,BODY_LEG_LEFT,BODY_LEG_RIGHT)

	defense_rating = list(
		BLADE = 25,
		BLUNT = 25,
		PIERCE = 25,
		LASER = 25,
		ARCANE = 25,
		HEAT = 50,
		COLD = 25,
		BIO = 25,
		HOLY = 25,
		DARK = 25,
	)
	additional_clothing = list(
		/obj/item/clothing/head/helmet/explorer_suit,
		/obj/item/clothing/mask/gas/mining
	)

	size = SIZE_6


	blocks_clothing = SLOT_TORSO_U

	value = 100

	slowdown_mul_worn = 1.1