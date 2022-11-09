/recipe/bullet_press/du
	name = "depleted uranium base"
	desc = "base recipe for du rounds"
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
/recipe/bullet_press/du/rifle_308
	name = "depleted uranium 308"

	required_item_grid = list(
		"a2" = "/obj/item/material/pellets/uranium_235",

		"b2" = "/obj/item/crafting/ingredient/part/gunpowder",
		"b3" = "/obj/item/magazine/rifle_308",

		"c2" = "/obj/item/crafting/ingredient/part/bullet_casings"
	)
	product = list("/obj/item/magazine/rifle_308/du" = 100)
	consume_id_amount = list("/obj/item/crafting/ingredient/part/gunpowder" = 40,"/obj/item/crafting/ingredient/part/bullet_casings" = 40,
	"/obj/item/material/pellets/uranium_235" = 40)