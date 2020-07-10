/obj/item/clothing/back/storage/backpack/
	name = "backpack"
	icon = 'icons/obj/item/clothing/back/backpack/grey.dmi'
	desc = "Vamanos!"
	desc_extended = "A plain backpack intended for use in storing items in one convienent location. Contains plenty of pockets for easy storage. Do note that carrying backpacks slows you down somewhat."
	rarity = RARITY_COMMON

	dynamic_inventory_count = MAX_INVENTORY_X*3

	size = MAX_INVENTORY_X*3*SIZE_2
	container_max_size = SIZE_3

	weight = WEIGHT_3

	value = 40

	slowdown_mul_worn = 1.3
	slowdown_mul_held = 1.2

/obj/item/clothing/back/storage/backpack/white
	icon = 'icons/obj/item/clothing/back/backpack/white.dmi'
	color = COLOR_GREY

/obj/item/clothing/back/storage/backpack/grey
	icon = 'icons/obj/item/clothing/back/backpack/white.dmi'
	color = COLOR_GREY

/obj/item/clothing/back/storage/backpack/black
	icon = 'icons/obj/item/clothing/back/backpack/white.dmi'
	color = COLOR_BLACK