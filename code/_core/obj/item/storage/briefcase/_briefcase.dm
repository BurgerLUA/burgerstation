/obj/item/storage/briefcase/
	name = "brown briefcase"
	desc = "An typical brown briefcase."
	icon_state = "briefcase"

	size = 12

	is_container = TRUE
	container_max_size = 3
	dynamic_inventory_count = 4

/obj/item/storage/briefcase/deagle
	name = "golden eagle collector's kit"
	desc = "A gold plated .50ae eagle handcannon. AMURICA."
	icon_state = "briefcase_deagle"

	container_max_size = 2
	dynamic_inventory_count = 6

/obj/item/storage/briefcase/deagle/on_spawn()
	inventories[1].add_held_object(new /obj/item/weapon/ranged/bullet/magazine/pistol/gold_eagle(src.loc),bypass_checks = TRUE)
	for(var/i=2,i<=6,i++)
		var/obj/item/magazine/M = new /obj/item/magazine/pistol_50ae(src.loc)
		M.on_spawn()
		M.update_icon()
		inventories[i].add_held_object(M,bypass_checks = TRUE)
