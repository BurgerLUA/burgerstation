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
	armor = /armor/leather/mining

	size = SIZE_2


	value = 80


/obj/item/clothing/feet/shoes/halo/spartan/left
	name = "MJOLNIR Mark V left Leg Armour"
	icon_state = "inventory_left"
	icon_state_worn = "worn_left"

	item_slot = SLOT_FOOT
	item_slot_mod = SLOT_MOD_LEFT
	protected_limbs = list(BODY_FOOT_LEFT)