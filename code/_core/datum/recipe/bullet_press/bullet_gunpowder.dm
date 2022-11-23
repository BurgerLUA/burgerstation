/recipe/bullet_press/bullet_gunpowder
	name = "bullet to gunpowder"

	required_item_grid = list(
		"a2" = null,

		"b2" = /obj/item/weapon/melee/tool/wirecutters,
		"b3" = /obj/item/bullet_cartridge,

		"c2" = null
	)
	product = list(
		/obj/item/crafting/ingredient/part/gunpowder = 100
	)
	consume_id_amount = list(
		/obj/item/weapon/melee/tool/wirecutters = 0
	)