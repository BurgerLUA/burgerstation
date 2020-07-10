/obj/item/clothing/back/storage/satchel/
	name = "grey satchel"
	desc = "WEARING BACKPACKS IS LRP!!!"
	desc_extended = "A satchel for carrying items. Has less space than a backpack, but slows you down the least."
	icon = 'icons/obj/item/clothing/back/satchel/grey.dmi'
	rarity = RARITY_COMMON

	dynamic_inventory_count = MAX_INVENTORY_X*2

	size = MAX_INVENTORY_X*2*SIZE_2
	container_max_size = SIZE_3

	weight = WEIGHT_2

	value = 30

	slowdown_mul_worn = 1.1
	slowdown_mul_held = 1.05

/obj/item/clothing/back/storage/satchel/loadout/new_player/fill_inventory()
	new /obj/item/clothing/mask/gas(src)
	new /obj/item/storage/emergency(src)
	new /obj/item/pinpointer/landmark(src)
	new /obj/item/clothing/overwear/coat/hoodie/grey(src)
	new /obj/item/weapon/melee/torch/flashlight(src)
	return ..()