/recipe/workbench/stock_reinforcement

	name = "stock_reinforcement"

	required_item_grid = list(
		"a1" = null,
		"a2" = null,
		"a3" = null,

		"b1" = "/obj/item/crafting/ingredient/alloy/titanium/gun",
		"b2" = "/obj/item/crafting/ingredient/alloy/titanium/gun",
		"b3" = null,

		"c1" = null,
		"c2" = "/obj/item/crafting/ingredient/alloy/titanium/gun",
		"c3" = null
	)


	product = list("/obj/item/attachment/barrel_mod/reinforced_stock" = 100)

/recipe/workbench/barrel_reinforcement

	name = "barrel_reinforcement"

	required_item_grid = list(
		"a1" = null,
		"a2" = null,
		"a3" = null,

		"b1" = "/obj/item/crafting/ingredient/alloy/titanium/gun",
		"b2" = "/obj/item/crafting/ingredient/alloy/titanium/gun",
		"b3" = "/obj/item/crafting/ingredient/alloy/titanium/gun",

		"c1" = null,
		"c2" = null,
		"c3" = null
	)
	product = list("/obj/item/attachment/barrel_mod/reinforced_barrel" = 100)