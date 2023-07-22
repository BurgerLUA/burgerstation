/obj/item/clothing/overwear/armor/halo/insurrection
	name = "V12L Body Armor"
	desc = "Don't mess with guys in that armor!"
	desc_extended = "The V12L Body Armor is composed of materials salvaged from a wide array of UNSC equipment for a lightweight design based off the M22L Body Armor crafted by X-52 for the new armor series being rolled out from Eridanus Secundus."
	icon = 'icons/obj/item/clothing/suit/ins.dmi'
	loyalty_tag = "Syndicate"

	rarity = RARITY_MYTHICAL

	defense_rating = list(
		BLADE = AP_SWORD,
		BLUNT = AP_CLUB,
		PIERCE = AP_CLUB,
		LASER = -AP_AXE,
		ARCANE = -AP_AXE,
		HEAT = AP_SWORD,
		COLD = AP_SWORD,
		BOMB = AP_SWORD,
		BIO = AP_SWORD,
		RAD = AP_SWORD,
		PAIN = AP_CLUB
	)

	size = SIZE_5

	protected_limbs = list(BODY_TORSO,BODY_GROIN,BODY_ARM_LEFT,BODY_ARM_RIGHT,BODY_HAND_RIGHT,BODY_HAND_LEFT)

	value = 300