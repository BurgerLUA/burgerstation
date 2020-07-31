/obj/item/clothing/back/storage/satchel/
	name = "grey satchel"
	desc = "WEARING BACKPACKS IS LRP!!!"
	desc_extended = "A satchel for carrying items. Has less space than a backpack, but slows you down the least."
	icon = 'icons/obj/item/clothing/back/satchel/grey.dmi'
	rarity = RARITY_COMMON

	dynamic_inventory_count = MAX_INVENTORY_X*2

	size = MAX_INVENTORY_X*2*SIZE_2
	container_max_size = SIZE_3



	value = 30

	slowdown_mul_worn = 1.1
	slowdown_mul_held = 1.1

/obj/item/clothing/back/storage/satchel/loadout/new_player/fill_inventory()
	new /obj/item/clothing/mask/gas(src)
	new /obj/item/storage/emergency(src)
	new /obj/item/pinpointer/landmark(src)
	new /obj/item/clothing/overwear/coat/hoodie/grey(src)
	new /obj/item/weapon/melee/torch/flashlight(src)
	new /obj/item/weapon/ranged/bullet/revolver/detective(src)
	new /obj/item/magazine/clip/revolver/bullet_38(src)
	new /obj/item/bullet_cartridge/revolver_38(src)
	new /obj/item/paper/book/controls(src)
	return ..()