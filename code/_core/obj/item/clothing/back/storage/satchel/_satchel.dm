/obj/item/clothing/back/storage/satchel/
	name = "grey satchel"
	icon = 'icons/obj/items/clothing/back/satchel/grey.dmi'
	rarity = RARITY_COMMON

	dynamic_inventory_count = MAX_INVENTORY_X*2

	size = MAX_INVENTORY_X*2*SIZE_2
	container_max_size = SIZE_3

	weight = WEIGHT_2

	value = 10


/obj/item/clothing/back/storage/satchel/loadout/stealth
	name = "stealth satchel"




/obj/item/clothing/back/storage/satchel/loadout/stealth/fill_inventory()
	new /obj/item/clothing/uniform/stealth(src)
	new /obj/item/clothing/feet/shoes/carbon_boot(src)
	new /obj/item/clothing/feet/shoes/carbon_boot/left(src)
	new /obj/item/clothing/hands/gloves/colored/black(src)
	new /obj/item/clothing/hands/gloves/colored/black/left(src)
	new /obj/item/clothing/head/hood/skimask/black(src)
	new /obj/item/clothing/glasses/ninja(src)
	new /obj/item/clothing/overwear/armor/carbon_armor(src)
	new /obj/item/weapon/melee/energy/sword/katana(src)
	new /obj/item/storage/pouch/triple/black/filled/stealth(src)
	new /obj/item/weapon/ranged/bullet/magazine/rifle/heavy_sniper(src)
	new /obj/item/magazine/sniper_762(src)
	new /obj/item/magazine/sniper_762(src)
	new /obj/item/hand_teleporter(src)

	return ..()