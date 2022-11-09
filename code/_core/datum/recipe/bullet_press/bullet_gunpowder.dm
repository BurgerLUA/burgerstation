/recipe/bullet_press/bullet_gunpowder
	name = "bullet to gunpowder"
	//todo- bullet type to gunpowder amounts?
	required_item_grid = list(
		"a2" = null,

		"b2" = "/obj/item/weapon/melee/tool/wirecutters",
		"b3" = "/obj/item/bullet_cartridge",

		"c2" = null
	)
	product = list("/obj/item/crafting/ingredient/part/gunpowder" = 100)