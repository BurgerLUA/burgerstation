/obj/item/clothing/overwear/hardsuit/crystal_guardian
	name = "crystal guardian's armor"
	desc = "A hardsuit forged with crystals and enchanted alloy that's used by the mystical Crystal Guardians."
	desc_extended = "Little is known about the origin of Crystal Guardians, their attunement towards crystal based magic is unparalelled and in turn is utilized in all of their equipment."
	icon = 'icons/obj/item/clothing/suit/crystal_guardian.dmi'
	rarity = RARITY_MYTHICAL

	defense_rating = list(
		BLADE = AP_GREATSWORD,
		BLUNT = AP_CLUB,
		PIERCE = AP_AXE,
		LASER = -AP_CLUB,
		ARCANE = AP_GREATCLUB,
		HEAT = -AP_CLUB,
		COLD = AP_CLUB,
		BOMB = AP_AXE,
		BIO = AP_SWORD,
		RAD = AP_SWORD
	)

	size = SIZE_7


	additional_clothing = list(/obj/item/clothing/head/helmet/hardsuit/crystal_guardian)

	value = 2000

	loyalty_tag = null //Anyone can use