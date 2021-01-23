/obj/item/clothing/overwear/armor/bone
	name = "bone armor"
	icon = 'icons/obj/item/clothing/suit/bone_armor.dmi'
	desc = "I've got a BONE to pick with ya!"
	desc_extended = "Armor made from bones. Metal as fuck."
	item_slot = SLOT_TORSO_A
	worn_layer = LAYER_MOB_CLOTHING_HARDSUIT
	rarity = RARITY_MYTHICAL

	protected_limbs = list(BODY_TORSO,BODY_GROIN,BODY_ARM_LEFT,BODY_ARM_RIGHT,BODY_HAND_LEFT,BODY_HAND_RIGHT,BODY_LEG_LEFT,BODY_LEG_RIGHT)

	defense_rating = list(
		BLADE = AP_AXE,
		BLUNT = AP_AXE,
		PIERCE = AP_AXE,
		ARCANE = AP_SWORD,
		HEAT = AP_CLUB,
		DARK = AP_CLUB,
		HOLY = -AP_CLUB,
		PAIN = AP_CLUB
	)

	size = SIZE_6

	blocks_clothing = SLOT_TORSO_A | SLOT_TORSO_O | SLOT_TORSO_U

	value = 500