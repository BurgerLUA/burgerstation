/recipe/workbench/honkmother_pin

	name = "honkmother pin"

	required_item_grid = list(
		"a1" = /obj/item/bikehorn/magic, "a2" = /obj/item/firing_pin/electronic/iff/nanotrasen/nyantrasen, "a3" = null,

		"b1" = null, "b2" = null, "b3" = null,

		"c1" = null, "c2" = null, "c3" = null
	)


	secret = TRUE
	product = /obj/item/firing_pin/electronic/iff/nanotrasen/honkmother

/*
/recipe/workbench/recipe_binder

	name = "recipe binder"

	required_item_grid = list(
		"a1" = /obj/item/crafting/ingredient/part/tape, "a2" = /obj/item/material/wood/normal, "a3" = null,

		"b1" = /obj/item/material/wood/normal, "b2" = /obj/item/paper, "b3" = null,

		"c1" = /obj/item/crafting/ingredient/part/tape, "c2" = /obj/item/material/wood/normal, "c3" = null
	)


	product = /obj/item/storage/recipe_binder
*/


/recipe/workbench/empty_box

	name = "empty box"

	required_item_grid = list(
		"a1" = null, "a2" = /obj/item/material/sheet/steel, "a3" = null,

		"b1" = /obj/item/material/sheet/steel, "b2" = /obj/item/material/sheet/steel, "b3" = /obj/item/material/sheet/steel,

		"c1" = null, "c2" = /obj/item/material/sheet/steel, "c3" = null
	)

	product = /obj/item/crafting/ingredient/part/metal_box