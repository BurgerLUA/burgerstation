/recipe/bullet_press/incen
	name = "incen base"
	desc = "base recipe for incen rounds"
	desc_extended = "bullet press recipe description"

	required_item_grid = list(
		/*
		Second value is the path of the item as string
		"a2" = null, //A pellet

		"b2" = null, // The gunpowder
		"b3" = null, // A mag to fill with bullets

		"c2" = null, // The Casings
		*/
	)
/recipe/bullet_press/incen/shotgun_23
	name = "shotgun 23 incen"

	required_item_grid = list(

		"a2" = "/obj/item/material/pellets/magnesium",

		"b2" = null,
		"b3" = "/obj/item/bullet_cartridge/shotgun_23/",

		"c2" = null,

	)

	product = list("/obj/item/bullet_cartridge/shotgun_23/fire" = 100)
	required_item_grid_amount = list("/obj/item/material/pellets/magnesium" = 4)

/recipe/bullet_press/incen/shotgun_12
	name = "shotgun 12 incen"

	required_item_grid = list(

		"a2" = "/obj/item/material/pellets/magnesium",

		"b2" = null,
		"b3" = "/obj/item/bullet_cartridge/shotgun_12",

		"c2" = null,

	)

	product = list("/obj/item/bullet_cartridge/shotgun_12/fire" = 100)
	required_item_grid_amount = list("/obj/item/material/pellets/magnesium" = 2)

/recipe/bullet_press/incen/sniper_50
	name = "sniper 50 incen"

	required_item_grid = list(

		"a2" = "/obj/item/material/pellets/magnesium",

		"b2" = "/obj/item/crafting/ingredient/part/gunpowder",
		"b3" = "/obj/item/magazine/sniper_50",

		"c2" = "/obj/item/crafting/ingredient/part/bullet_casings",

	)

	product = list("/obj/item/magazine/sniper_50/incendiary" = 100)
	required_item_grid_amount = list("/obj/item/material/pellets/magnesium" = 32,"/obj/item/crafting/ingredient/part/gunpowder" = 40,"/obj/item/crafting/ingredient/part/bullet_casings" = 8)