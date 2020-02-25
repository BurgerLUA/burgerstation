/obj/item/clothing/back/storage/dufflebag/
	name = "dufflebag"
	icon = 'icons/obj/items/clothing/back/dufflebag/white.dmi'
	rarity = RARITY_COMMON

	dynamic_inventory_count = MAX_INVENTORY_X*3

	size = MAX_INVENTORY_X*3*SIZE_3
	container_max_size = SIZE_4

	weight = WEIGHT_4

	value = 20

/obj/item/clothing/back/storage/dufflebag/loadout/pmc
	color = COLOR_BLACK
	vendor_name = "\improper Rilfeman's Kit"

/obj/item/clothing/back/storage/dufflebag/grey
	color = COLOR_GREY

/obj/item/clothing/back/storage/dufflebag/loadout/pmc/fill_inventory()
	new /obj/item/radio(src)
	new /obj/item/pinpointer/custom(src)
	new /obj/item/pinpointer/landmark(src)
	new /obj/item/clothing/uniform/jumpsuit/pmc(src)
	new /obj/item/clothing/feet/shoes/black_boots(src)
	new /obj/item/clothing/feet/shoes/black_boots/left(src)
	new /obj/item/clothing/hands/gloves/colored/padded/black(src)
	new /obj/item/clothing/hands/gloves/colored/padded/black/left(src)
	new /obj/item/clothing/head/hood/skimask/black(src)
	new /obj/item/clothing/overwear/armor/bulletproof(src)
	new /obj/item/storage/pouch/double/black/filled/rifle_308(src)
	new /obj/item/storage/pouch/double/black/filled/rifle_308(src)
	new /obj/item/clothing/head/hat/beret(src)
	new /obj/item/clothing/belt/storage/colored/black/filled/pmc(src)
	new /obj/item/weapon/ranged/bullet/magazine/rifle(src)
	new /obj/item/paper/firearms(src)
	return ..()

/obj/item/clothing/back/storage/dufflebag/engineering
	name = "engineering dufflebag"
	icon = 'icons/obj/items/clothing/back/dufflebag/engineering.dmi'

/obj/item/clothing/back/storage/dufflebag/engineering/loadout/fill_inventory()
	new /obj/item/radio(src)
	new /obj/item/pinpointer/custom(src)
	new /obj/item/pinpointer/landmark(src)
	new /obj/item/clothing/uniform/jumpsuit/engineering(src)
	new /obj/item/clothing/overwear/armor/hardsuit/engineering(src)
	new /obj/item/clothing/belt/storage/tool/filled(src)
	new /obj/item/material/sheet/steel/spawn_50(src)
	new /obj/item/material/sheet/steel/spawn_50(src)
	new /obj/item/material/rod/steel/spawn_50(src)
	new /obj/item/material/sheet/glass/spawn_50(src)
	new /obj/item/weapon/melee/tool/rcd(src)
	new /obj/item/matter_cartridge(src)
	new /obj/item/matter_cartridge(src)
	new /obj/item/matter_cartridge(src)
	new /obj/item/storage/pouch/triple/brown/filled/pdw(src)
	new /obj/item/storage/pouch/triple/brown/filled/pdw(src)
	new /obj/item/weapon/ranged/bullet/magazine/smg/pdw(src)
	return ..()


/obj/item/clothing/back/storage/dufflebag/engineering
	name = "engineering dufflebag"
	icon = 'icons/obj/items/clothing/back/dufflebag/engineering.dmi'