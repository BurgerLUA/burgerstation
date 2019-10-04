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

/obj/item/storage/briefcase/syndicate/sniper/on_spawn()
	inventories[1].add_held_object(new /obj/item/weapon/ranged/bullet/magazine/heavy_sniper(src.loc),bypass_checks = TRUE)
	for(var/i=2,i<=dynamic_inventory_count,i++)
		var/obj/item/magazine/M = new /obj/item/magazine/sniper_50(src.loc)
		M.on_spawn()
		M.update_icon()
		inventories[i].add_held_object(M,bypass_checks = TRUE)

/obj/item/storage/briefcase/syndicate/smg
	name = "syndicate smg pack"
	desc = "For all your smg needs."
	container_max_size = 3
	dynamic_inventory_count = 4

/obj/item/storage/briefcase/syndicate/smg/on_spawn()
	inventories[1].add_held_object(new /obj/item/weapon/ranged/bullet/magazine/smg(src.loc),bypass_checks = TRUE)
	for(var/i=2,i<=dynamic_inventory_count,i++)
		var/obj/item/magazine/M = new /obj/item/magazine/smg_45(src.loc)
		M.on_spawn()
		M.update_icon()
		inventories[i].add_held_object(M,bypass_checks = TRUE)

/obj/item/storage/briefcase/syndicate/rifle
	name = "syndicate assault rifle pack"
	desc = "For all your rifle needs."
	container_max_size = 3
	dynamic_inventory_count = 4

/obj/item/storage/briefcase/syndicate/rifle/on_spawn()
	inventories[1].add_held_object(new /obj/item/weapon/ranged/bullet/magazine/assault_rifle(src.loc),bypass_checks = TRUE)
	for(var/i=2,i<=dynamic_inventory_count,i++)
		var/obj/item/magazine/M = new /obj/item/magazine/rifle_762(src.loc)
		M.on_spawn()
		M.update_icon()
		inventories[i].add_held_object(M,bypass_checks = TRUE)

/obj/item/storage/briefcase/syndicate/pistol
	name = "syndicate pistol pack"
	desc = "For all your pistol needs."
	container_max_size = 2
	dynamic_inventory_count = 6

/obj/item/storage/briefcase/syndicate/pistol/on_spawn()
	inventories[1].add_held_object(new /obj/item/weapon/ranged/bullet/magazine/pistol(src.loc),bypass_checks = TRUE)
	for(var/i=2,i<=dynamic_inventory_count,i++)
		var/obj/item/magazine/M = new /obj/item/magazine/pistol_10mm(src.loc)
		M.on_spawn()
		M.update_icon()
		inventories[i].add_held_object(M,bypass_checks = TRUE)


/obj/item/storage/briefcase/syndicate/autoshotgun
	name = "syndicate autoshotgun pack"
	desc = "For all your shotgun needs."
	container_max_size = 3
	dynamic_inventory_count = 3

/obj/item/storage/briefcase/syndicate/autoshotgun/on_spawn()
	inventories[1].add_held_object(new /obj/item/weapon/ranged/bullet/magazine/autoshotgun(src.loc),bypass_checks = TRUE)
	for(var/i=2,i<=dynamic_inventory_count,i++)
		var/obj/item/magazine/M = new /obj/item/magazine/shotgun_auto(src.loc)
		M.on_spawn()
		M.update_icon()
		inventories[i].add_held_object(M,bypass_checks = TRUE)
