/recipe/workbench/belt_of_holding

	name = "belt of holding"

	required_item_grid = list(
		"a1" = "/obj/item/weapon/melee/tool/wirecutters",
		"a2" = "/obj/item/powercell/bluespace",
		"a3" = "/obj/item/tempering/quality/clothing/repair",

		"b1" = "/obj/item/crafting/ingredient/thread/durathread/",
		"b2" = "/obj/item/clothing/back/storage/satchel/bluespace",
		"b3" = "/obj/item/crafting/ingredient/thread/durathread/",

		"c1" = "/obj/item/material/ingot/titanium",
		"c2" = "/obj/item/material/ingot/diamond",
		"c3" = "/obj/item/material/ingot/titanium"
	)

	product = list("/obj/item/clothing/belt/holding"=100)
	consume_id_amount = list("/obj/item/weapon/melee/tool/wirecutters" = 0)