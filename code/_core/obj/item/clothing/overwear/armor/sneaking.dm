/obj/item/clothing/overwear/armor/sneaking
	name = "sneaking armor"
	icon = 'icons/obj/item/clothing/suit/sneaking_vest.dmi'
	desc = "For solid protection."
	desc_extended = "A flashy sound-aborbing vest used by mercenaries. Doesn't do much to make you sneakier, but it protests decently."

	size = SIZE_3

	value = 200

	defense_rating = list(
		BLADE = AP_SWORD,
		BLUNT = AP_SWORD,
		PIERCE = AP_AXE,
		LASER = 10,
		ARCANE = -AP_AXE,
		HEAT = AP_SWORD,
		COLD = AP_SWORD
	)