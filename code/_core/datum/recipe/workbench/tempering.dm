/recipe/workbench/ranged_to_bow
	name = "ranged to bow"

	required_items = list("obj/item/tempering/quality/ranged","/obj/item/weapon/melee/tool/screwdriver")

	no_consume_ids = list("/obj/item/weapon/melee/tool/screwdriver")

	product = /obj/item/tempering/quality/ranged/bow

/recipe/workbench/bow_to_ranged

	name = "bow to ranged"

	required_items = list("obj/item/tempering/quality/ranged/bow","/obj/item/weapon/melee/tool/screwdriver")

	no_consume_ids = list("/obj/item/weapon/melee/tool/screwdriver")

	product = /obj/item/tempering/quality/ranged

/recipe/workbench/clothing_repair
	
	name = "sewing kit"

	required_items = list("obj/item/material/rod/steel","/obj/item/crafting/ingredient/thread/synthcloth")


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