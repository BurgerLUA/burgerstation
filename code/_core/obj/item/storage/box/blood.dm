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

/obj/item/storage/blood_box/update_inventory()
	. = ..()
	for(var/k in src.inventories)
		var/obj/hud/inventory/I = k
		if(length(I.contents))
			return .
	qdel(src)

/obj/item/storage/blood_box/Finalize()
	. = ..()
	prune_inventory()

/obj/item/storage/blood_box/blood/fill_inventory()
	new /obj/item/clothing/head/hat/tricorn(src)
	new /obj/item/clothing/neck/neck_wrap(src)
	new /obj/item/clothing/overwear/coat/trench(src)
	new /obj/item/weapon/melee/sword/uncoiled(src)
	new /obj/item/weapon/melee/sword/csaw(src)
	new /obj/item/weapon/melee/sword/cblade(src)
	. = ..()

/obj/item/storage/blood_box/duum/fill_inventory()
	new /obj/item/clothing/overwear/hardsuit/doom(src)
	new /obj/item/clothing/head/helmet/full/doom(src)
	new /obj/item/weapon/ranged/bullet/pump/shotgun/doom(src)
	new /obj/item/storage/ammo/buckshot(src)
	. = ..()

/obj/item/storage/blood_box/witchunt/fill_inventory()
	new /obj/item/clothing/head/hat/witchunter(src)
	new /obj/item/clothing/overwear/coat/chaplain/witchunter(src)
	. = ..()

/obj/item/storage/blood_box/holy_45/fill_inventory()
	new /obj/item/weapon/ranged/bullet/magazine/pistol/holy45(src)
	new /obj/item/magazine/holy45(src)
	new /obj/item/magazine/holy45(src)
	new /obj/item/magazine/holy45(src)
	new /obj/item/magazine/holy45(src)
	new /obj/item/magazine/holy45(src)
	. = ..()

/obj/item/storage/blood_box/sniper_20/fill_inventory()
	new /obj/item/weapon/ranged/bullet/magazine/rifle/sniper_20(src)
	new /obj/item/magazine/sniper_20mm(src)
	new /obj/item/magazine/sniper_20mm(src)
	new /obj/item/magazine/sniper_20mm(src)
	new /obj/item/magazine/sniper_20mm(src)
	new /obj/item/magazine/sniper_20mm(src)
	new /obj/item/magazine/sniper_20mm(src)
	. = ..()


/obj/item/storage/blood_box/fiendish/fill_inventory()
	new /obj/item/weapon/ranged/bullet/revolver/fiendish(src)
	new /obj/item/bullet_cartridge/pistol_45{amount=6}(src)
	new /obj/item/bullet_cartridge/pistol_45{amount=6}(src)
	new /obj/item/bullet_cartridge/pistol_45{amount=6}(src)
	new /obj/item/bullet_cartridge/pistol_45{amount=6}(src)
	new /obj/item/bullet_cartridge/pistol_45{amount=6}(src)
	new /obj/item/bullet_cartridge/pistol_45{amount=6}(src)
	new /obj/item/bullet_cartridge/pistol_45{amount=6}(src)
	. = ..()


/obj/item/storage/blood_box/holy_grenades/fill_inventory()
	new /obj/item/grenade/fuse/holy(src)
	new /obj/item/grenade/fuse/holy(src)
	new /obj/item/grenade/fuse/holy(src)
	new /obj/item/grenade/fuse/holy(src)
	new /obj/item/grenade/fuse/holy(src)
	new /obj/item/grenade/fuse/holy(src)
	. = ..()

