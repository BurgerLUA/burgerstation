/obj/item/clothing/overwear/armor/drake_armor
	name = "ash drake armor"
	desc = "More like Drakeskin Armor, eh?"
	desc_extended = "Armor made from the hardened scales of an Elder Ash Drake."
	icon = 'icons/obj/item/clothing/suit/drake_armor.dmi'
	item_slot = SLOT_TORSO_A
	worn_layer = LAYER_MOB_CLOTHING_HARDSUIT
	rarity = RARITY_MYTHICAL

	protected_limbs = list(BODY_TORSO,BODY_GROIN,BODY_ARM_LEFT,BODY_ARM_RIGHT,BODY_HAND_LEFT,BODY_HAND_RIGHT,BODY_LEG_LEFT,BODY_LEG_RIGHT)

	defense_rating = list(
		BLADE = AP_AXE,
		BLUNT = AP_AXE,
		PIERCE = AP_AXE,
		LASER = AP_SWORD,
		ARCANE = AP_SWORD,
		HEAT = AP_SWORD,
		COLD = -AP_SWORD,
		HOLY = -AP_AXE,
		DARK = AP_AXE,
		PAIN = AP_CLUB
	)

	size = SIZE_7

	additional_clothing = list(/obj/item/clothing/head/helmet/drake)

	blocks_clothing = SLOT_TORSO_A | SLOT_TORSO_O | SLOT_TORSO_U

	value = 1100