/recipe/workbench/ranged_to_bow_kit
	name = "ranged to bow"

	required_items = list("obj/item/tempering/quality/ranged" = 1,
	"/obj/item/weapon/melee/tool/screwdriver" = 1)

	no_consume_ids = list("/obj/item/weapon/melee/tool/screwdriver")

	product = /obj/item/tempering/quality/ranged_bow

/recipe/workbench/clothing_repair
	
	name = "sewing kit"

	required_items = list("obj/item/material/rod/steel" = 1,
	"/obj/item/crafting/ingredient/thread/synthcloth" = 1)


	product = /obj/item/tempering/quality/clothing/repair

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

	product = /obj/item/tempering/quality/melee

	secret = TRUE
/recipe/workbench/repair_consumable

	required_items = list("/obj/item/crafting/ingredient/part/scrap" = 1,
	"/obj/item/crafting/ingredient/part/tape" = 1,
	"/obj/item/crafting/ingredient/part/electronics" = 1,
	"/obj/item/weapon/melee/toolbox" = 1)

	product = /obj/item/tempering/quality/lesser_consumable