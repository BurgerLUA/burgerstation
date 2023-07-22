/obj/item/clothing/overwear/armor/halo/covenant/kigyar
	name = "Kig-Yar Combat Harness"
	desc = "Aliens! Yay!"
	desc_extended = "A protective harness for use during combat."
	icon = 'icons/obj/item/clothing/suit/kigyar.dmi'

	rarity = RARITY_MYTHICAL

	defense_rating = list(
		BLADE = AP_SWORD,
		BLUNT = AP_SWORD,
		PIERCE = AP_SWORD,
		LASER = AP_AXE,
		ARCANE = -AP_AXE,
		BOMB = AP_AXE
	)

	size = SIZE_5

	flags_clothing = FLAG_CLOTHING_NOHUMAN
	protected_limbs = list(BODY_TORSO,BODY_GROIN,BODY_LEG_LEFT,BODY_LEG_RIGHT,BODY_FOOT_LEFT,BODY_FOOT_RIGHT)

	value = 300