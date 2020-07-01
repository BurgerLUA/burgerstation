/obj/item/clothing/overwear/armor/molded_armor
	name = "light armor"
	desc = "ERROR"
	desc = "How did you even get this? It won't protect you from anything."
	icon = 'icons/obj/item/clothing/suit/mod_chest_armor.dmi'

	dyeable = TRUE

/obj/item/clothing/overwear/armor/molded_armor/leather
	name = "light leather armor"
	desc = "It's like i'm wearing nothing at all!"
	desc_extended = "Armor made from leather. Very light and easy to make, but won't protect you from much."
	color = "#8C4438"

	defense_rating = list(
		BLADE = 25,
		BLUNT = 15,
		PIERCE = 15,
		COLD = 25
	)

	size = SIZE_3
	weight = WEIGHT_3

	value = 15

/obj/item/clothing/overwear/armor/molded_armor/security
	name = "armor plating"
	desc = "Hey, as long as it works."
	desc_extended = "A plate of armor with crude straps. Cheap and lightweight, but not really effective."
	color = COLOR_BLACK

	defense_rating = list(
		BLADE = 50,
		BLUNT = 50,
		PIERCE = 25
	)

	size = SIZE_3
	weight = WEIGHT_4

	value = 75

/obj/item/clothing/overwear/armor/molded_armor/security/nanotrasen
	color = COLOR_NANOTRASEN

/obj/item/clothing/overwear/armor/medium_armor
	name = "medium armor"
	desc = "9/10, it's ok."
	desc_extended = "A very cheap armor. Not very effective, but better than nothing."
	icon = 'icons/obj/item/clothing/suit/medium_chest_armor.dmi'

	value = 30

	protected_limbs = list(BODY_TORSO,BODY_GROIN)

	dyeable = TRUE