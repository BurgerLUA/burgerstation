/obj/item/clothing/neck/sorcerer
	name = "sorcerer's cape"
	icon = 'icons/obj/item/clothing/suit/sorcerer_cape.dmi'
	desc = "A sorcerer's cape. Frequently dyed to show one's proficiency in a specific magical art."
	desc_extended = "A cape donning colors that represent one's proficiency in a specific magical art."


	protected_limbs = list(BODY_TORSO)

	defense_rating = list(
		MAGIC = 75,
		COLD = 25,
		HEAT = 15,
		HOLY = -75,
		DARK = 75
	)

	rarity = RARITY_RARE

	size = SIZE_2
	weight = WEIGHT_2

	worn_layer = LAYER_MOB_CLOTHING_NECK_OVER

	additional_clothing = list(/obj/item/clothing/head/hood/sorcerer_hood)

	dyeable = TRUE

	value = 950
