/recipe/bullet_press/hv_grenade
	name = "hv grenade"

	required_item_grid = list(
		"a2" = "/obj/item/material/sheet/steel",

		"b2" = "/obj/item/crafting/ingredient/part/gunpowder",
		"b3" = null,

		"c2" = "/obj/item/crafting/ingredient/part/bullet_casings"
	)
	product = list("/obj/item/bullet_cartridge/grenade_40mm/hv" = 100)
	consume_id_amount = list("/obj/item/crafting/ingredient/part/gunpowder" = 10)
/recipe/bullet_press/hv_grenade
	name = "du grenade"

	required_item_grid = list(
		"a2" = "/obj/item/material/sheet/uranium_235",

		"b2" = "/obj/item/crafting/ingredient/part/gunpowder",
		"b3" = null,

		"c2" = "/obj/item/crafting/ingredient/part/bullet_casings"
	)
	product = list("/obj/item/bullet_cartridge/grenade_40mm/du" = 100)
	consume_id_amount = list("/obj/item/crafting/ingredient/part/gunpowder" = 20)