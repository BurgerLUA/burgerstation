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

/recipe/bullet_press/du/nuke
	name = "depleted uranium 308"
	secret = TRUE
	required_item_grid = list(
		"a2" = "/obj/item/material/ingot/uranium_235",

		"b2" = "/obj/item/crafting/ingredient/part/gunpowder",
		"b3" = "/obj/item/bullet_cartridge/rocket_70mm",

		"c2" = null
	)
	product = list("/obj/item/bullet_cartridge/rocket_70mm/nuclear" = 100)
	consume_id_amount = list("/obj/item/crafting/ingredient/part/gunpowder" = 50,"/obj/item/material/ingot/uranium_235" = 10)

/recipe/bullet_press/du/rifle_50
	name = "depleted uranium 50"

	required_item_grid = list(
		"a2" = "/obj/item/material/pellets/uranium_235",

		"b2" = "/obj/item/crafting/ingredient/part/gunpowder",
		"b3" = "/obj/item/magazine/sniper_50",

		"c2" = "/obj/item/crafting/ingredient/part/bullet_casings"
	)
	product = list("/obj/item/magazine/sniper_50/du" = 100)
	consume_id_amount = list("/obj/item/crafting/ingredient/part/gunpowder" = 32,"/obj/item/crafting/ingredient/part/bullet_casings" = 8,
	"/obj/item/material/pellets/uranium_235" = 16)
/recipe/bullet_press/du/rifle_308_nato
	name = "depleted uranium 308 nato"

	required_item_grid = list(
		"a2" = "/obj/item/material/pellets/uranium_235",

		"b2" = "/obj/item/crafting/ingredient/part/gunpowder",
		"b3" = "/obj/item/magazine/sniper_308/nato",

		"c2" = "/obj/item/crafting/ingredient/part/bullet_casings"
	)
	product = list("/obj/item/magazine/sniper_308/nato/du" = 100)
	consume_id_amount = list("/obj/item/crafting/ingredient/part/gunpowder" = 30,"/obj/item/crafting/ingredient/part/bullet_casings" = 30,
	"/obj/item/material/pellets/uranium_235" = 30)
	
/recipe/bullet_press/du/sniper_127
	name = "depleted uranium 127 sniper"

	required_item_grid = list(
		"a2" = "/obj/item/material/pellets/uranium_235",

		"b2" = "/obj/item/crafting/ingredient/part/gunpowder",
		"b3" = "/obj/item/magazine/sniper_127",

		"c2" = "/obj/item/crafting/ingredient/part/bullet_casings"
	)
	product = list("/damagetype/ranged/bullet/sniper_127/du" = 100)
	consume_id_amount = list("/obj/item/crafting/ingredient/part/gunpowder" = 32,"/obj/item/crafting/ingredient/part/bullet_casings" = 4,
	"/obj/item/material/pellets/uranium_235" = 16)

/recipe/bullet_press/du/sniper_20
	name = "depleted uranium 20 sniper"

	required_item_grid = list(
		"a2" = "/obj/item/material/pellets/uranium_235",

		"b2" = "/obj/item/crafting/ingredient/part/gunpowder",
		"b3" = "/obj/item/bullet_cartridge/sniper_20",

		"c2" = "/obj/item/crafting/ingredient/part/bullet_casings"
	)
	product = list("/obj/item/bullet_cartridge/sniper_20/du" = 100)
	consume_id_amount = list("/obj/item/crafting/ingredient/part/gunpowder" = 64,"/obj/item/crafting/ingredient/part/bullet_casings" = 4,
	"/obj/item/material/pellets/uranium_235" = 32)