/obj/item/clothing/belt/storage/colored
	name = "storage belt"
	icon = 'icons/obj/items/clothing/belts/white.dmi'
	desc = "Don't make me get the belt."
	desc_extended = "Stores a robust amount of items that can easily and quickly be accessed."
	dyeable = TRUE

/obj/item/clothing/belt/storage/colored/black
	color = COLOR_BLACK

/obj/item/clothing/belt/storage/colored/grey
	color = COLOR_GREY

/obj/item/clothing/belt/storage/colored/gold
	color = COLOR_GOLD

/obj/item/clothing/belt/storage/colored/black/filled/pmc/fill_inventory()
	new /obj/item/weapon/ranged/bullet/magazine/pistol/tactical/mod(src)
	new /obj/item/magazine/pistol_45(src)
	new /obj/item/magazine/pistol_45(src)
	new /obj/item/magazine/pistol_45(src)
	new /obj/item/container/medicine/bandage(src)
	new /obj/item/container/medicine/ointment(src)
	new /obj/item/grenade/timed/explosive/(src)
	new /obj/item/grenade/timed/explosive/(src)
	return ..()

/obj/item/clothing/belt/storage/colored/black/filled/stealth/fill_inventory()
	new /obj/item/container/medicine/bandage/advanced(src)
	new /obj/item/container/medicine/ointment/advanced(src)
	return ..()

/obj/item/clothing/belt/storage/colored/black/filled/security/fill_inventory()
	new /obj/item/weapon/ranged/bullet/revolver/detective(src)
	new /obj/item/magazine/clip/revolver/bullet_38(src)
	new /obj/item/magazine/clip/revolver/bullet_38(src)
	new /obj/item/magazine/clip/revolver/bullet_38(src)
	new /obj/item/weapon/melee/energy/stunbaton(src)
	new /obj/item/weapon/melee/energy/shield(src)
	new /obj/item/container/medicine/bandage(src)
	new /obj/item/container/medicine/ointment(src)
	return ..()

/obj/item/clothing/belt/storage/colored/brown
	color = COLOR_BROWN

/obj/item/clothing/belt/storage/colored/brown/filled/miner/fill_inventory()
	new /obj/item/weapon/melee/tool/pickaxe(src)
	new /obj/item/storage/bags/mining(src)
	new /obj/item/weapon/ranged/bullet/revolver/traitor_357(src)
	new /obj/item/magazine/clip/revolver/bullet_357(src)
	new /obj/item/magazine/clip/revolver/bullet_357(src)
	new /obj/item/magazine/clip/revolver/bullet_357(src)
	new /obj/item/container/medicine/bandage(src)
	new /obj/item/container/medicine/ointment(src)
	return ..()


/obj/item/clothing/belt/storage/colored/orange
	color = "#FF6A00"


/obj/item/clothing/belt/storage/colored/orange/filled/scientist/fill_inventory()
	new /obj/item/weapon/melee/tool/crowbar/red(src)
	return ..()
