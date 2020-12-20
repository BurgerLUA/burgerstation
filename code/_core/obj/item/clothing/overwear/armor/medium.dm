/obj/item/clothing/overwear/armor/medium_armor
	name = "medium armor"
	desc = "9/10, it's ok."
	desc_extended = "A very cheap armor. Not very effective, but better than nothing."
	icon = 'icons/obj/item/clothing/suit/medium_chest_armor.dmi'

	value = 120

	protected_limbs = list(BODY_TORSO,BODY_GROIN)

	dyeable = TRUE

/obj/item/clothing/overwear/armor/medium_armor/security
	name = "padded stab vest"
	desc = "Morning, Mr. Freeman. Looks like you're running late."
	desc_extended = "A bulky anti-stab vest designed to absorb medium sized bladed weapons. Also offers some decent protection against bullets as well."
	color = COLOR_BLACK

	defense_rating = list(
		BLADE = AP_GREATSWORD,
		BLUNT = AP_AXE,
		PIERCE = AP_AXE,
		ARCANE = -AP_AXE
	)

	size = SIZE_4


	value = 200