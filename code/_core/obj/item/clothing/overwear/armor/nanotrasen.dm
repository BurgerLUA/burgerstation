/obj/item/clothing/overwear/armor/nanotrasen
	name = "\improper NanoERT armor"
	icon = 'icons/obj/item/clothing/suit/nano.dmi'
	polymorphs = list(
		"base" = COLOR_BLACK,
		"chest" = COLOR_BLACK,
		"shoulders" = COLOR_NANOTRASEN
	)

	worn_layer = LAYER_MOB_CLOTHING_ARMOR

	armor = /armor/hardsuit/combat/nanotrasen

	value = 1200

	size = SIZE_7

/obj/item/clothing/overwear/armor/nanotrasen/deathsquad

	armor = /armor/hardsuit/combat/nanotrasen/plus

	polymorphs = list(
		"base" = COLOR_GREY_DARK,
		"chest" = COLOR_NANOTRASEN,
		"shoulders" = COLOR_BLACK,
		"extra" = "#910000"
	)