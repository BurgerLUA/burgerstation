/obj/item/clothing/glasses/sun
	name = "sunglasses"
	rarity = RARITY_RARE
	desc = "Deal with it."
	desc_extended = "A simple pair of sleek sunglasses."
	icon = 'icons/obj/items/clothing/glasses/sunglasses.dmi'

	defense_rating = list(
		LASER = ARMOR_A,
		HOLY = ARMOR_C,
		DARK = -ARMOR_A
	)


/obj/item/clothing/glasses/sun/ABOMB
	name = "\improper A.B.O.M.B. glasses"
	icon = 'icons/obj/items/clothing/glasses/ABOMB.dmi'
	rarity = RARITY_MYTHICAL
	defense_rating = list(
		LASER = ARMOR_B,
		HOLY = ARMOR_D,
		DARK = -ARMOR_A,
		BOMB = ARMOR_A
	)