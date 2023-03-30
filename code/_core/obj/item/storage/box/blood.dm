/obj/item/storage/blood_box/
	name = "blood box"
	icon = 'icons/obj/item/storage/boxes.dmi'
	icon_state = "bloodbox"

	is_container = TRUE
	container_max_size = SIZE_10
	size = SIZE_10*8

	dynamic_inventory_count = 8

	value = 20

	value_burgerbux = 1

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
	. = ..()

/obj/item/storage/blood_box/holy_grenades/fill_inventory()
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