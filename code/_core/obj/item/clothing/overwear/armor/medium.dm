/obj/item/clothing/overwear/armor/medium_armor
	name = "padded stab vest"
	desc = "Morning, Mr. Freeman. Looks like you're running late."
	desc_extended = "A bulky anti-stab vest designed to absorb medium sized bladed weapons. Also offers some decent protection against bullets as well."
	icon = 'icons/obj/item/clothing/suit/medium_chest_armor.dmi'

	value = 120

	defense_rating = list(
		BLADE = 80,
		BLUNT = 40,
		PIERCE = 40,
		ARCANE = -40
	)

	protected_limbs = list(BODY_TORSO,BODY_GROIN)

	dyeable = TRUE

	size = SIZE_4

/obj/item/clothing/overwear/armor/medium_armor/black
	color = COLOR_BLACK

/obj/item/clothing/overwear/armor/medium_armor/merc
	color = "#BCAC86"


