/obj/item/clothing/back/storage/backpack/
	name = "backpack"
	icon = 'icons/obj/items/clothing/back/backpack/white.dmi'

	dynamic_inventory_count = MAX_INVENTORY_X*3

	size = MAX_INVENTORY_X*3*SIZE_3
	container_max_size = SIZE_3

	weight = WEIGHT_3

/obj/item/clothing/back/storage/backpack/loadout/security
	color = COLOR_BLACK
	vendor_name = "\improper Laser Carbine Kit (Security)"

/obj/item/clothing/back/storage/backpack/loadout/security/fill_inventory()
	new /obj/item/clothing/uniform/jumpsuit/dark/security(src)
	new /obj/item/clothing/feet/shoes/black_boots(src)
	new /obj/item/clothing/feet/shoes/black_boots/left(src)
	new /obj/item/clothing/hands/gloves/colored/padded/black(src)
	new /obj/item/clothing/hands/gloves/colored/padded/black/left(src)
	new /obj/item/clothing/glasses/security_hud(src)
	new /obj/item/clothing/overwear/armor/medium_armor/security(src)
	new /obj/item/clothing/head/helmet/security/tactical_helmet(src)
	new /obj/item/clothing/belt/storage/colored/black/filled/security/(src)
	new /obj/item/storage/pouch/double/black/filled/cell(src)
	new /obj/item/storage/pouch/double/black/filled/cell(src)
	new /obj/item/weapon/ranged/laser/hybrid/carbine(src)
	new /obj/item/powercell/industrial(src)
	new /obj/item/powercell/industrial(src)
	return ..()
