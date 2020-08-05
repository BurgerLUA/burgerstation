/obj/item/clothing/overwear/armor/molded_armor
	name = "light armor"
	desc = "ERROR"
	desc = "How did you even get this? It won't protect you from anything."
	icon = 'icons/obj/item/clothing/suit/mod_chest_armor.dmi'

	protected_limbs = list(BODY_TORSO)

	dyeable = TRUE

	slowdown_mul_worn = 1.1

/obj/item/clothing/overwear/armor/molded_armor/security
	name = "kevlar vest"
	desc = "Hey, as long as it works."
	desc_extended = "A reinforced kevlar vest designed to stop small bullets."
	color = COLOR_BLACK

	defense_rating = list(
		BLUNT = 65,
		PIERCE = 25,
		ARCANE = -25
	)

	size = SIZE_3


	value = 200