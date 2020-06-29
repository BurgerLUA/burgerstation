/obj/item/clothing/overwear/armor/bulletproof
	name = "bulletproof armor"
	icon = 'icons/obj/item/clothing/suit/bulletproof_vest.dmi'
	item_slot = SLOT_TORSO_A
	desc = "Protecting against the greytide since 2193."
	desc_extended = "A sturdy chestplate of bulletproof armor. Should protect against most small arms fire."

	protected_limbs = list(BODY_TORSO)

	rarity = RARITY_UNCOMMON

	defense_rating = list(
		BLADE = 25,
		BLUNT = 25,
		PIERCE = 75,
		LASER = -25,
		MAGIC = -25
	)

	size = SIZE_4
	weight = WEIGHT_4

	value = 50