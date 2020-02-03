/obj/item/storage/briefcase/syndicate
	name = "black briefcase"
	desc = "An evil black briefcase."
	icon_state = "briefcase_dark"

	size = 12

	is_container = TRUE
	container_max_size = 3
	dynamic_inventory_count = 4

/obj/item/storage/briefcase/syndicate/sniper
	name = "syndicate sniper pack"
	desc = "For all your sniper needs."
	container_max_size = 4
	dynamic_inventory_count = 3

/obj/item/storage/briefcase/syndicate/sniper/fill_inventory()
	new /obj/item/weapon/ranged/bullet/magazine/rifle/heavy_sniper(src)
	for(var/i=2,i<=dynamic_inventory_count,i++)
		var/obj/item/magazine/M = new /obj/item/magazine/sniper_50(src)
		M.on_spawn()
		M.update_icon()
	return ..()

/obj/item/storage/briefcase/syndicate/smg
	name = "syndicate smg pack"
	desc = "For all your smg needs."
	container_max_size = 3
	dynamic_inventory_count = 4

/obj/item/storage/briefcase/syndicate/smg/fill_inventory()
	new /obj/item/weapon/ranged/bullet/magazine/smg(src)
	for(var/i=2,i<=dynamic_inventory_count,i++)
		var/obj/item/magazine/M = new /obj/item/magazine/smg_45(src)
		M.on_spawn()
		M.update_icon()
	return ..()

/obj/item/storage/briefcase/syndicate/rifle
	name = "syndicate assault rifle pack"
	desc = "For all your rifle needs."
	container_max_size = 3
	dynamic_inventory_count = 4

/obj/item/storage/briefcase/syndicate/rifle/fill_inventory()
	new /obj/item/weapon/ranged/bullet/magazine/rifle(src)
	for(var/i=2,i<=dynamic_inventory_count,i++)
		var/obj/item/magazine/M = new /obj/item/magazine/rifle_223(src)
		M.on_spawn()
		M.update_icon()
	return ..()

/obj/item/storage/briefcase/syndicate/pistol
	name = "syndicate pistol pack"
	desc = "For all your pistol needs."
	container_max_size = 2
	dynamic_inventory_count = 6

/obj/item/storage/briefcase/syndicate/pistol/fill_inventory()
	new /obj/item/weapon/ranged/bullet/magazine/pistol(src)
	for(var/i=2,i<=dynamic_inventory_count,i++)
		var/obj/item/magazine/M = new /obj/item/magazine/pistol_10mm(src)
		M.on_spawn()
		M.update_icon()
		inventories[i].add_held_object(M,bypass_checks = TRUE)
	return ..()


/obj/item/storage/briefcase/syndicate/autoshotgun
	name = "syndicate autoshotgun pack"
	desc = "For all your shotgun needs."
	container_max_size = 3
	dynamic_inventory_count = 3

/obj/item/storage/briefcase/syndicate/autoshotgun/fill_inventory()
	new /obj/item/weapon/ranged/bullet/magazine/shotgun/bull(src)
	for(var/i=2,i<=dynamic_inventory_count,i++)
		var/obj/item/magazine/M = new /obj/item/magazine/shotgun_auto(src)
		M.on_spawn()
		M.update_icon()
	return ..()


/obj/item/storage/briefcase/syndicate/revoler
	name = "syndicate revolver pack"
	desc = "For all your pistol needs."
	container_max_size = 2
	dynamic_inventory_count = 5

/obj/item/storage/briefcase/syndicate/revoler/fill_inventory()
	new /obj/item/weapon/ranged/bullet/revolver/traitor_357(src)
	for(var/i=2,i<=dynamic_inventory_count,i++)
		var/obj/item/magazine/M = new /obj/item/magazine/clip/revolver/bullet_357(src)
		M.on_spawn()
		M.update_icon()
	return ..()