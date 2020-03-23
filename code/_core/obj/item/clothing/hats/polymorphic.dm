/obj/item/clothing/head/helmet/polymorphic
	name = "police helmet"
	icon = 'icons/obj/items/clothing/hats/security_new.dmi'
	desc = "RUSH B"
	desc_extended = "A sturdy tactical helmet. Protects your head from bullets."

	defense_rating = list(
		BLADE = ARMOR_C,
		BLUNT = ARMOR_C,
		PIERCE = ARMOR_C,
		LASER = ARMOR_D,
		MAGIC = -ARMOR_C,
		BOMB = ARMOR_D
	)

	size = SIZE_3
	weight = WEIGHT_2

	value = 40

	color_primary = "#FFFFFF"
	color_secondary = "#FFFFFF"
	color_tertiary = "#FFFFFF"

	color_primary_desc = "base helmet"
	color_secondary_desc = "ear protection"
	color_tertiary_desc = "helmet stripe"

	polymorphic = TRUE

	no_initial_blend = TRUE


/obj/item/clothing/head/helmet/polymorphic/test
	color_primary = "#FF0000"
	color_secondary = "#00FF00"
	color_tertiary = "#0000FF"


/obj/item/clothing/head/helmet/polymorphic/security
	color_primary = COLOR_BLACK
	color_secondary = COLOR_SECURITY
	color_tertiary = COLOR_SECURITY

/obj/item/clothing/head/helmet/polymorphic/engineering
	color_primary = COLOR_ENGINEERING
	color_secondary = COLOR_BROWN
	color_tertiary = COLOR_ORANGE


/obj/item/clothing/head/helmet/polymorphic/medical
	color_primary = COLOR_WHITE
	color_secondary = COLOR_MEDICAL
	color_tertiary = COLOR_MEDICAL