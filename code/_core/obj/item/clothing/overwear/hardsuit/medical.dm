/obj/item/clothing/overwear/hardsuit/medical
	name = "medical voidsuit"
	desc = "Out the fucking way!"
	desc_extended = "A hardsuit worn by medics while retrieving corpses to avoid becoming a corpse themselves."
	icon = 'icons/obj/item/clothing/suit/hardsuit_medical.dmi'
	rarity = RARITY_UNCOMMON

	defense_rating = list(
		BLADE = AP_SWORD,
		BLUNT = AP_AXE,
		PIERCE = AP_AXE,
		LASER = AP_SWORD,
		ARCANE = -AP_AXE,
		HEAT = AP_AXE,
		COLD = AP_AXE,
		BOMB = AP_SWORD,
		BIO = AP_GREATCLUB,
		RAD = AP_CLUB
	)

	size = SIZE_7


	additional_clothing = list(/obj/item/clothing/head/helmet/hardsuit/medical)

	value = 1000

	loyalty_tag = "NanoTrasen"