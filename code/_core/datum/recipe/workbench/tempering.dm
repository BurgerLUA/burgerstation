/recipe/workbench/ranged_to_bow_kit
	name = "ranged to bow"

	required_items = list("/obj/item/tempering/quality/ranged" = 1,
	"/obj/item/weapon/melee/tool/screwdriver" = 1)

	required_item_grid_amount = list("/obj/item/weapon/melee/tool/screwdriver" = 0)

	product = list("/obj/item/tempering/quality/ranged_bow" = 100)

/recipe/workbench/clothing_repair

	name = "sewing kit"

	required_items = list("/obj/item/material/rod/steel" = 1,
	"/obj/item/crafting/ingredient/thread/synthcloth" = 1)


	product = list("/obj/item/tempering/quality/clothing/repair" = 100)

/recipe/workbench/whetstone

	required_item_grid = list(
		"a1" = "/obj/item/crafting/ingredient/part/sandpaper",
		"a2" = "/obj/item/crafting/ingredient/part/sandpaper",
		"a3" = "/obj/item/crafting/ingredient/part/sandpaper",

		"b1" = "/obj/item/material/ingot/iron",
		"b2" = "/obj/item/material/ingot/iron",
		"b3" = "/obj/item/material/ingot/iron",

		"c1" = null,
		"c2" = null,
		"c3" = null
	)

	product = list("/obj/item/tempering/quality/melee" = 100)

	secret = TRUE

/recipe/workbench/dura_thread_quality

	required_item_grid = list(
		"a1" = "/obj/item/crafting/ingredient/thread/durathread/",
		"a2" = "/obj/item/crafting/ingredient/thread/durathread/",
		"a3" = "/obj/item/crafting/ingredient/thread/durathread/",

		"b1" = null,
		"b2" = null,
		"b3" = null,

		"c1" = null,
		"c2" = null,
		"c3" = null
	)

	product = list("/obj/item/tempering/quality/clothing" = 100)

	secret = TRUE
/recipe/workbench/repair_consumable

	required_items = list("/obj/item/crafting/ingredient/part/scrap" = 1,
	"/obj/item/crafting/ingredient/part/tape" = 1,
	"/obj/item/crafting/ingredient/part/electronics" = 1,
	"/obj/item/crafting/ingredient/part/metal_box" = 1)

	product = list("/obj/item/tempering/quality/lesser_consumable" = 100)
