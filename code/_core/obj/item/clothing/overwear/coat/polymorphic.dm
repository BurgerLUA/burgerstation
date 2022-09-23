/obj/item/clothing/overwear/coat/polymorphic
	name = "jacket"
	desc = "A nice jacket."
	desc_extended = "Can hold a single low-size item."
	icon = 'icons/obj/item/clothing/suit/jacket.dmi'

	no_initial_blend = TRUE

	is_container = TRUE
	dynamic_inventory_count = 1

	container_max_size = SIZE_2

	size = SIZE_3

	armor = /armor/cloth/hoodie

	dyeable = TRUE

	polymorphs = list(
		"base" = "#FFFFFF"
	)

	value = 40


/obj/item/clothing/overwear/coat/polymorphic/black
	polymorphs = list(
		"base" = COLOR_BLACK
	)

/obj/item/clothing/overwear/coat/polymorphic/nanotrasen_dark
	polymorphs = list(
		"base" = COLOR_NANOTRASEN_DARK
	)