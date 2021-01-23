SUBSYSTEM_DEF(menu)
	name = "Menu Subsystem"
	desc = "Stores all the known menus in a list."
	priority = SS_ORDER_FIRST

	var/list/menu/all_menus = list()

/subsystem/menu/Initialize()

	for(var/t in subtypesof(/menu/))
		var/menu/M = new t
		all_menus[M.type] = M

	log_subsystem(name,"Initialized [length(all_menus)] menus.")

	for(var/k in all_clients)
		var/client/C = all_clients[k]
		preload_assets(C)

	return ..()


/subsystem/menu/proc/preload_assets(var/client/C)

	for(var/k in all_menus)
		var/menu/M = all_menus[k]
		M.cache_resources(C)

	return TRUE

/proc/open_menu(var/client/C,var/menu_id)
	spawn
		var/menu/M = SSmenu.all_menus[menu_id]
		M.open(C)

/proc/close_menu(var/client/C,var/menu_id)
	spawn
		var/menu/M = SSmenu.all_menus[menu_id]
		M.close(C)

proc/get_menu(menu_id)
	return SSmenu.all_menus[menu_id]

/proc/send_load(var/client/C,menu_id) //A common command I use every time I visit your mom.
	var/menu/M = SSmenu.all_menus[menu_id]
	if(!M)
		log_error("Warning: Could not load menu [menu_id ? menu_id : "NULL"] for [C.get_debug_name()]!")
		return FALSE
	M.on_load(C)