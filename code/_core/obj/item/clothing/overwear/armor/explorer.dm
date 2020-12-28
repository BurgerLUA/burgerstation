/obj/item/clothing/overwear/armor/explorer_suit
	name = "explorer's suit"
	desc = "CARGO WE NEED DIAMONDS"
	desc_extended = "A protective suit of armor worn by miners to protect from the megafauna. Also comes with a hood and gas mask that can be brought up by shift-clicking the suit."
	icon = 'icons/obj/item/clothing/suit/explorer_suit.dmi'
	worn_layer = LAYER_MOB_CLOTHING_HARDSUIT
	rarity = RARITY_UNCOMMON

	protected_limbs = list(BODY_TORSO,BODY_GROIN,BODY_ARM_LEFT,BODY_ARM_RIGHT,BODY_HAND_LEFT,BODY_HAND_RIGHT,BODY_LEG_LEFT,BODY_LEG_RIGHT)

	defense_rating = list(
		BLADE = AP_SWORD,
		BLUNT = AP_AXE,
		PIERCE = AP_AXE,
		LASER = AP_AXE,
		ARCANE = AP_SWORD,
		HEAT = AP_SWORD,
		COLD = AP_SWORD,
		BIO = AP_AXE,
		HOLY = AP_AXE,
		DARK = AP_AXE,
		PAIN = AP_AXE
	)
	additional_clothing = list(
		/obj/item/clothing/head/helmet/full/explorer
	)

	size = SIZE_6

	value = 100