/obj/item/storage/blood_box/
	name = "blood box"
	icon = 'icons/obj/item/storage/boxes.dmi'
	icon_state = "bloodbox"

	is_container = TRUE
	container_max_size = SIZE_10
	size = SIZE_10*8

	dynamic_inventory_count = 8

	value_burgerbux = 1

	value = 0

/obj/item/storage/blood_box/Finalize()
	. = ..()
	prune_inventory()

/obj/item/storage/blood_box/sniper_20/fill_inventory()
	new /obj/item/weapon/ranged/bullet/magazine/rifle/sniper_20(src)
	new /obj/item/magazine/sniper_20mm(src)
	new /obj/item/magazine/sniper_20mm(src)
	new /obj/item/magazine/sniper_20mm(src)
	new /obj/item/magazine/sniper_20mm(src)
	new /obj/item/magazine/sniper_20mm(src)
	new /obj/item/magazine/sniper_20mm(src)
	new /obj/item/magazine/sniper_20mm(src)
	. = ..()

/obj/item/storage/blood_box/holy_grenades/fill_inventory()
	new /obj/item/grenade/fuse/holy(src)
	new /obj/item/grenade/fuse/holy(src)
	new /obj/item/grenade/fuse/holy(src)
	new /obj/item/grenade/fuse/holy(src)
	new /obj/item/grenade/fuse/holy(src)
	new /obj/item/grenade/fuse/holy(src)
	new /obj/item/grenade/fuse/holy(src)
	new /obj/item/grenade/fuse/holy(src)
	. = ..()
/obj/item/storage/blood_box/minigun/fill_inventory()
	new /obj/item/weapon/ranged/bullet/magazine/rifle/minigun(src)
	new /obj/item/magazine/minigun_46/du(src)
	new /obj/item/magazine/minigun_46/du(src)
	new /obj/item/magazine/minigun_46/du(src)
	new /obj/item/magazine/minigun_46/du(src)
	new /obj/item/magazine/minigun_46/du(src)
	new /obj/item/magazine/minigun_46/du(src)
	new /obj/item/magazine/minigun_46/du(src)
	. = ..()


/obj/item/storage/blood_box/auto_gauss/fill_inventory()
	new /obj/item/weapon/ranged/bullet/magazine/rifle/gauss_gun/auto(src)
	new /obj/item/magazine/gauss_gun(src)
	new /obj/item/magazine/gauss_gun(src)
	new /obj/item/magazine/gauss_gun(src)
	new /obj/item/magazine/gauss_gun/ap(src)
	new /obj/item/magazine/gauss_gun/explosive(src)
	new /obj/item/magazine/gauss_gun/incendiary(src)
	new /obj/item/magazine/gauss_gun/ion(src)
	. = ..()