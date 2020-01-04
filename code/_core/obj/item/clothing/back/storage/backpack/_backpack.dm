/obj/item/clothing/back/storage/backpack/
	name = "grey backpack"
	icon = 'icons/obj/items/clothing/back/backpack/white.dmi'

	dynamic_inventory_count = MAX_INVENTORY_X*3

	size = MAX_INVENTORY_X*3*SIZE_3
	container_max_size = SIZE_3

	weight = WEIGHT_3

/obj/item/clothing/back/storage/backpack/loadout/security
	name = "security backpack"
	color = "#404040"

/obj/item/clothing/back/storage/backpack/loadout/security/fill_inventory()
	new /obj/item/clothing/uniform/jumpsuit/dark/security(src)
	new /obj/item/clothing/feet/shoes/black_boots(src)
	new /obj/item/clothing/feet/shoes/black_boots/left(src)
	new /obj/item/clothing/hands/gloves/colored/padded/black(src)
	new /obj/item/clothing/hands/gloves/colored/padded/black/left(src)
	new /obj/item/clothing/glasses/sun(src)
	new /obj/item/clothing/head/hat/beret/black(src)
	new /obj/item/clothing/neck/cloak/red(src)
	new /obj/item/clothing/overwear/armor/medium_armor/security(src)
