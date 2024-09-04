/obj/item/clothing/belt/bandoliers/bandolier
	name = "error bandolier"
	desc = "For the aspiring sweeper."
	desc_extended = "A not-so-fancy bandolier meant to hold a number of shotgun shells. ALT+Click to grab additional shells while already holding a shell."

	icon = 'icons/obj/item/clothing/belts/bandolier_12.dmi'
	worn_layer = LAYER_MOB_CLOTHING_COAT_OVER
	dyeable = TRUE


	value = 0
	size = SIZE_3

	stored_bullets = list()

	bullet_count = 0
	max_bullets = 0
	bullet_type = /obj/item/bullet_cartridge

	num_overlays = 5

/obj/item/clothing/belt/bandoliers/get_base_value()
	return max_bullets*3

/obj/item/clothing/belt/bandoliers/bandolier/shotgun_12
	name = "12 gauge shotgun bandolier"
	desc_extended = "A not-so-fancy bandolier meant to hold a number of 12 gauge shotgun shells. Click to grab a handful of shells, or ALT+Click to take one."
	icon = 'icons/obj/item/clothing/belts/bandolier_12.dmi'
	max_bullets = 100
	bullet_type = /obj/item/bullet_cartridge/shotgun_12
	value = 1 //Dummy value.

/obj/item/clothing/belt/bandoliers/bandolier/shotgun_20
	name = "20 gauge shotgun bandolier"
	desc_extended = "A dyed bandolier meant to hold a number of 20 gauge shotgun shells. Click to grab a handful of shells, or ALT+Click to take one."
	icon = 'icons/obj/item/clothing/belts/bandolier_20.dmi'
	max_bullets = 120
	bullet_type = /obj/item/bullet_cartridge/shotgun_20
	value = 1 //Dummy value.

/obj/item/clothing/belt/bandoliers/bandolier/shotgun_23
	name = "23x75mmR shotgun bandolier"
	desc_extended = "A surplus bandolier meant to hold a number of 23x75mmR shotgun shells. Click to grab a handful of shells, or ALT+Click to take one."
	icon = 'icons/obj/item/clothing/belts/bandolier_23.dmi'
	max_bullets = 80
	bullet_type = /obj/item/bullet_cartridge/shotgun_23
	value = 1 //Dummy value.