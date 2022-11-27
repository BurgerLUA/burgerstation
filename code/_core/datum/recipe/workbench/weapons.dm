/recipe/workbench/shuriken

	name = "shuriken"

	required_item_grid = list(
		"a1" = null,
		"a2" = "/obj/item/material/rod/steel",
		"a3" = null,

		"b1" = "/obj/item/material/rod/steel",
		"b2" = null,
		"b3" = "/obj/item/material/rod/steel",

		"c1" = null,
		"c2" = "/obj/item/material/rod/steel",
		"c3" = null
	)

	product = list("/obj/item/weapon/ranged/thrown/shuriken" = 100)
	amount = list(10)
/recipe/workbench/kitchen_shuriken

	name = "kitchen shuriken"

	required_item_grid = list(
		"a1" = null,
		"a2" = "/obj/item/weapon/melee/sword/chef_knife",
		"a3" = null,

		"b1" = "/obj/item/weapon/melee/sword/chef_knife",
		"b2" = "/obj/item/crafting/ingredient/part/tape",
		"b3" = "/obj/item/weapon/melee/sword/chef_knife",

		"c1" = null,
		"c2" = "/obj/item/weapon/melee/sword/chef_knife",
		"c3" = null
	)

	product = list("/obj/item/weapon/ranged/thrown/kitchen_shuriken" = 100)
	amount = list(10)

/recipe/workbench/bootleg_landmine

	name = "landmine bootleg"

	required_item_grid = list(
		"a1" = "/obj/item/device/proximity",
		"a2" = "/obj/item/weapon/melee/tool/screwdriver",
		"a3" = "/obj/item/grenade/timed/explosive",

		"b1" = null,
		"b2" = null,
		"b3" = null,

		"c1" = null,
		"c2" = null,
		"c3" = null
	)

	product = list("/obj/item/grenade/landmine/proximity/explosive" = 100)
	required_item_grid_amount = list("/obj/item/weapon/melee/tool/screwdriver" = 0)
