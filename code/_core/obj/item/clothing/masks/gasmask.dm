/obj/item/clothing/mask/gas
	name = "classic gas mask"
	icon = 'icons/obj/item/clothing/masks/gasmask.dmi'
	flags_clothing = FLAG_CLOTHING_NOBEAST_HEAD
	desc = "Oxygen not included."
	desc_extended = "A modern gas mask. Filters out most forms of gas."
	rarity = RARITY_UNCOMMON

	defense_rating = list(
		BLADE = AP_SWORD,
		BLUNT = AP_SWORD,
		PIERCE = AP_SWORD,
		BIO = AP_GREATSWORD,
		RAD = AP_DAGGER
	)

	size = SIZE_2


	value = 40

/obj/item/clothing/mask/gas/clown
	name = "clown mask"
	icon = 'icons/obj/item/clothing/masks/clown.dmi'
	desc = "Where the clown gets their power."
	desc_extended = "A flawless clown mask and wig."

	defense_rating = list(
		BLADE = AP_SWORD,
		BLUNT = AP_SWORD,
		PIERCE = AP_SWORD,
		BIO = AP_GREATSWORD,
		RAD = AP_DAGGER,
		HOLY = -AP_GREATSWORD,
		DARK = AP_GREATSWORD
	)

	size = SIZE_2


	value = 120

/obj/item/clothing/mask/gas/mining
	name = "advanced gas mask"
	icon = 'icons/obj/item/clothing/masks/mining.dmi'
	flags_clothing = FLAG_CLOTHING_NOBEAST_HEAD
	desc = "Oxygen not included."
	desc_extended = "An advanced gas mask. Filters out most forms of gas."
	rarity = RARITY_RARE

	defense_rating = list(
		BLADE = AP_CLUB,
		BLUNT = AP_SWORD,
		PIERCE = AP_SWORD,
		BIO = AP_GREATAXE,
		RAD = AP_DAGGER
	)

	size = SIZE_2

	value = 160

/obj/item/clothing/mask/gas/syndicate
	name = "ancient syndicate gas mask"
	desc = "Fearsome."
	desc_extended = "An old syndicate gas mask previously used by syndicate operatives."
	icon = 'icons/obj/item/clothing/masks/gasmask_syndicate.dmi'

/obj/item/clothing/mask/gas/syndicate
	name = "cyborg skull gas mask"
	desc = "Fearsome."
	desc_extended = "An old syndicate gas mask previously used by syndicate operatives."
	icon = 'icons/obj/item/clothing/masks/gasmask_syndicate.dmi'


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

/obj/item/clothing/mask/gas/poly/security
	polymorphs = list(
		"base" = COLOR_BLACK,
		"eyes" = COLOR_SECURITY,
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

