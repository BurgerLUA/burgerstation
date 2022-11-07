/recipe/workbench/honkmother_pin

	name = "honkmother pin"

	required_items = list("/obj/item/bikehorn/magic" = 1,
	"/obj/item/firing_pin/electronic/iff/nanotrasen/nyantrasen" = 1)

	secret = TRUE
	product = /obj/item/firing_pin/electronic/iff/nanotrasen/honkmother

/recipe/workbench/recipe_binder

	name = "recipe binder"

	required_item_grid = list(
		"a1" = "/obj/item/crafting/ingredient/part/tape",
		"a2" = "/obj/item/material/wood/normal",
		"a3" = null,

		"b1" = "/obj/item/material/wood/normal",
		"b2" = "obj/item/paper",
		"b3" = null,

		"c1" = "/obj/item/crafting/ingredient/part/tape",
		"c2" = "/obj/item/material/wood/normal",
		"c3" = null
	)


	product = /obj/item/storage/recipe_binder