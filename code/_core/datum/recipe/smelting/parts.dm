/recipe/smelter/alchemy_bottle
	name = "alchemy bottle"

	required_items = list("/obj/item/material/ingot/cobalt" = 2,"/obj/item/container/simple/beaker/bottle" = 1)

	product = list("/obj/item/crafting/ingredient/part/alchemy_bottle" = 100)

/recipe/smelter/bullet_casings
	name = "bullet casings"

	required_items = list("/obj/item/material/ingot/brass" = 1,"/obj/item/crafting/ingredient/part/casing_mold" = 1)

	consume_id_amount = list("/obj/item/crafting/ingredient/part/casing_mold" = 0)

	product = list("/obj/item/crafting/ingredient/part/bullet_casings" = 100)
	amount = list(30)


	