/obj/item/clothing/mask/gas
	name = "classic gas mask"
	icon = 'icons/obj/item/clothing/masks/gasmask.dmi'
	flags_clothing = FLAG_CLOTHING_NOBEAST_HEAD
	desc = "Oxygen not included."
	desc_extended = "A modern gas mask. Filters out most forms of gas."
	rarity = RARITY_UNCOMMON

	defense_rating = list(
		BLADE = 20,
		BLUNT = 20,
		PIERCE = 20,
		BIO = 80,
		RAD = 10
	)

	size = SIZE_2


	value = 40

/obj/item/clothing/mask/gas/mining
	name = "advanced gas mask"
	icon = 'icons/obj/item/clothing/masks/mining.dmi'
	flags_clothing = FLAG_CLOTHING_NOBEAST_HEAD
	desc = "Oxygen not included."
	desc_extended = "An advanced gas mask. Filters out most forms of gas."
	rarity = RARITY_RARE

	defense_rating = list(
		BLADE = 60,
		BLUNT = 20,
		PIERCE = 20,
		BIO = 100,
		RAD = 10
	)

	size = SIZE_2

	value = 160

/obj/item/clothing/mask/gas/syndicate
	name = "ancient syndicate gas mask"
	desc = "Fearsome."
	desc_extended = "An old syndicate gas mask previously used by syndicate operatives."
	icon = 'icons/obj/item/clothing/masks/gasmask_syndicate.dmi'

/obj/item/clothing/mask/gas/mercenary
	name = "mercenary gas mask"
	desc = "Profitable."
	desc_extended = "An old mercenary gas mask previously used by exclusion zone bounty hunters."
	icon = 'icons/obj/item/clothing/masks/gasmask_merc.dmi'

/obj/item/clothing/mask/gas/glass
	name = "open gas mask"
	desc = "Viewable."
	desc_extended = "An old glass gas mask previously used by irradiated subway scavengers."
	icon = 'icons/obj/item/clothing/masks/gasmask_glass.dmi'

/obj/item/clothing/mask/gas/tactical
	name = "tactical gas mask"
	desc = "Tactical."
	desc_extended = "An old tactical gas mask previously used by special ops."
	icon = 'icons/obj/item/clothing/masks/gasmask_tactical.dmi'

/obj/item/clothing/mask/gas/space_cop
	name = "space cop's mask"
	icon = 'icons/obj/item/clothing/masks/space_cop.dmi'
	flags_clothing = FLAG_CLOTHING_NOBEAST_HEAD
	desc = "Baton not included."
	desc_extended = "A space-age gas mask. Filters out most forms of gas."
	rarity = RARITY_UNCOMMON

/obj/item/clothing/mask/gas/poly
	name = "gas mask"
	icon = 'icons/obj/item/clothing/masks/gasmask_poly.dmi'
	polymorphs = list(
		"base" = COLOR_WHITE,
		"eyes" = COLOR_WHITE,
		"filter" = COLOR_WHITE
	)
	dyeable = TRUE


/obj/item/clothing/mask/gas/poly/grey
	polymorphs = list(
		"base" = COLOR_METAL,
		"eyes" = COLOR_GREEN,
		"filter" = COLOR_METAL
	)

/obj/item/clothing/mask/gas/poly/nanotrasen
	polymorphs = list(
		"base" = COLOR_BLACK,
		"eyes" = COLOR_NANOTRASEN,
		"filter" = COLOR_PLASTEEL
	)

/obj/item/clothing/mask/gas/poly/syndicate
	polymorphs = list(
		"base" = COLOR_BLACK,
		"eyes" = COLOR_RED,
		"filter" = COLOR_PLASTEEL
	)

/obj/item/clothing/mask/gas/poly/space_military
	polymorphs = list(
		"base" = COLOR_WHITE,
		"eyes" = COLOR_BLACK,
		"filter" = COLOR_PLASTEEL
	)

/obj/item/clothing/mask/gas/poly/engineering
	polymorphs = list(
		"base" = COLOR_BROWN,
		"eyes" = COLOR_ENGINEERING,
		"filter" = COLOR_PLASTEEL
	)

/obj/item/clothing/mask/gas/poly/chemistry
	polymorphs = list(
		"base" = COLOR_METAL,
		"eyes" = COLOR_CHEMISTRY,
		"filter" = COLOR_PLASTEEL
	)

/obj/item/clothing/mask/gas/poly/janitor
	polymorphs = list(
		"base" = COLOR_METAL,
		"eyes" = COLOR_PURPLE,
		"filter" = COLOR_METAL
	)

/obj/item/clothing/mask/gas/poly/science
	polymorphs = list(
		"base" = COLOR_WHITE,
		"eyes" = COLOR_SCIENCE,
		"filter" = COLOR_METAL
	)

