/recipe/workbench/weapon_part/blade/long/iron

	id = "create_iron_long_blade"

	required_item_grid = list( //The second value is the craft_id of the item.
		"a1" = null,
		"a2" = "ingot_iron",
		"a3" = null,

		"b1" = null,
		"b2" = "ingot_iron",
		"b3" = null,

		"c1" = null,
		"c2" = "ingot_iron",
		"c3" = null
	)
	product = /obj/item/weapon_part/blade/long/iron

	do_debug = TRUE



/recipe/workbench/weapon_part/handle/sword/iron

	id = "create_iron_sword_handle"

	required_item_grid = list( //The second value is the craft_id of the item.
		"a1" = null,
		"a2" = null,
		"a3" = null,

		"b1" = "ingot_iron",
		"b2" = null,
		"b3" = null,

		"c1" = null,
		"c2" = "ingot_iron",
		"c3" = null
	)
	product = /obj/item/weapon_part/handle/sword/iron



/recipe/workbench/weapon_part/binding/iron

	id = "create_iron_binding"

	required_item_grid = list( //The second value is the craft_id of the item.
		"a1" = null,
		"a2" = "ingot_iron",
		"a3" = null,

		"b1" = "ingot_iron",
		"b2" = null,
		"b3" = null,

		"c1" = null,
		"c2" = null,
		"c3" = null
	)
	product = /obj/item/weapon_part/binding/iron