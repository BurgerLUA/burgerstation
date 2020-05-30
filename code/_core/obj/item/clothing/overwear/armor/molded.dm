/obj/item/clothing/overwear/armor/molded_armor
	name = "light armor"
	icon = 'icons/obj/items/clothing/suit/mod_chest_armor.dmi'

	dyeable = TRUE

/obj/item/clothing/overwear/armor/molded_armor/leather
	name = "light leather armor"
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
	icon = 'icons/obj/items/clothing/suit/medium_chest_armor.dmi'

	value = 30

	protected_limbs = list(BODY_TORSO,BODY_GROIN)

	dyeable = TRUE