/obj/item/clothing/overwear/armor/explorer_suit
	name = "explorer's suit"
	desc = "CARGO WE NEED DIAMONDS"
	desc_extended = "A protective suit of armor worn by miners to protect from the megafauna. Also comes with a hood that can be brought up by shift-clicking the suit."
	icon = 'icons/obj/item/clothing/suit/explorer_suit.dmi'
	worn_layer = LAYER_MOB_CLOTHING_HARDSUIT
	rarity = RARITY_UNCOMMON

	protected_limbs = list(BODY_TORSO,BODY_GROIN,BODY_ARM_LEFT,BODY_ARM_RIGHT,BODY_HAND_LEFT,BODY_HAND_RIGHT,BODY_LEG_LEFT,BODY_LEG_RIGHT)

	defense_rating = list(
		BLADE = 20,
		BLUNT = 40,
		PIERCE = 40,
		LASER = 40,
		ARCANE = 20,
		HEAT = 20,
		COLD = 20,
		BIO = 40,
		HOLY = 40,
		DARK = 40,
		PAIN = 40
	)
	additional_clothing = list(
		/obj/item/clothing/head/helmet/full/explorer
	)

	size = SIZE_6

	value = 100