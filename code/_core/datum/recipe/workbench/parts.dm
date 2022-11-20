/recipe/workbench/sandpaper
	name = "sandpaper"

	required_items = list("/obj/item/material/sandstone" = 1,
	"/obj/item/weapon/melee/tool/hammer" = 1,
	"/obj/item/paper" = 1)

	consume_id_amount = list("/obj/item/weapon/melee/tool/hammer" = 0)

	product = list("/obj/item/crafting/ingredient/part/sandpaper" = 100)

/recipe/workbench/casing_mold

	name = "casing mold"

	required_item_grid = list(
		"a1" = null,
		"a2" = null,
		"a3" = null,

		"b1" = null,
		"b2" = "/obj/item/material/sheet",
		"b3" = null,

		"c1" = null,
		"c2" = "/obj/item/weapon/melee/tool/wirecutters",
		"c3" = null
	)

	consume_id_amount = list("/obj/item/weapon/melee/tool/wirecutters" = 0 )

	product = list("/obj/item/crafting/ingredient/part/casing_mold" = 100)

/recipe/workbench/dura_thread

	name = "durathread"

	required_item_grid = list(
		"a1" = "/obj/item/crafting/ingredient/thread/devilstrand",
		"a2" = "/obj/item/crafting/ingredient/thread/synthcloth",
		"a3" = "/obj/item/crafting/ingredient/thread/devilstrand",

		"b1" = "/obj/item/crafting/ingredient/thread/synthcloth",
		"b2" = "/obj/item/material/rod/plasteel",
		"b3" = "/obj/item/crafting/ingredient/thread/synthcloth",

		"c1" = "/obj/item/crafting/ingredient/thread/devilstrand",
		"c2" = "/obj/item/crafting/ingredient/thread/synthcloth",
		"c3" = "/obj/item/crafting/ingredient/thread/devilstrand"
	)

	product = list("/obj/item/crafting/ingredient/thread/durathread/" = 100)


/recipe/workbench/empty_box

	name = "empty box"

	required_item_grid = list(
		"a1" = null,
		"a2" = "/obj/item/material/sheet/steel",
		"a3" = null,

		"b1" = "/obj/item/material/sheet/steel",
		"b2" = "/obj/item/material/sheet/steel",
		"b3" = "/obj/item/material/sheet/steel",

		"c1" = null,
		"c2" = "/obj/item/material/sheet/steel",
		"c3" = null
	)

	product = list("/obj/item/crafting/ingredient/part/metal_box" = 100)
