/obj/item/clothing/neck/apron
	name = "leather apron"
	icon = 'icons/obj/items/clothing/suit/apron_leather.dmi'
	desc_extended = "A leather apron, perfect for the blacksmith in you."
	worn_layer = LAYER_MOB_CLOTHING_NECK_OVER

	protected_limbs = list(BODY_TORSO, BODY_GROIN)

	defense_rating = list(
		HEAT = ARMOR_B,
		LASER = ARMOR_C,
		BLUNT = ARMOR_D,
		BLADE = ARMOR_D,
		PIERCE = ARMOR_E,
	)