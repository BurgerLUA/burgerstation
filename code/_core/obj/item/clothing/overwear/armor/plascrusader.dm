/obj/item/clothing/overwear/armor/plascrusader
	name = "plascrusader armor"
	desc = "GOLD GOLD GOLD!"
	desc_extended = "A heavy chestplate made from gold metals and looks awesome."
	icon = 'icons/obj/item/clothing/suit/plascrusader.dmi'
	worn_layer = LAYER_MOB_CLOTHING_HARDSUIT
	rarity = RARITY_UNCOMMON

	protected_limbs = list(BODY_TORSO,BODY_GROIN)

	defense_rating = list(
		BLADE = AP_CLUB,
		BLUNT = AP_AXE,
		PIERCE = AP_AXE,
		LASER = AP_AXE,
		HEAT = -AP_AXE,
		ARCANE = -AP_CLUB,
		PAIN = AP_CLUB
	)

	size = SIZE_6

	value = 150

