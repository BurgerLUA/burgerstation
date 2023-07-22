/obj/item/clothing/overwear/armor/halo/covenant/unggoy
	name = "Grunt Combat Harness"
	desc = "Aliens! Yay!"
	desc_extended = "An armored protective vest worn by the Minor Unggoys."
	icon = 'icons/obj/item/clothing/suit/unggoy.dmi'

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

	flags_clothing = FLAG_CLOTHING_NOHUMAN
	protected_limbs = list(BODY_TORSO,BODY_GROIN,BODY_ARM_LEFT,BODY_ARM_RIGHT,BODY_LEG_LEFT,BODY_LEG_RIGHT)

	value = 300