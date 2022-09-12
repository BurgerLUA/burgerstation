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

	. = ..()

	for(var/k in all_mobs_with_clients)
		var/mob/M = k
		preload_assets(M)


/subsystem/menu/proc/preload_assets(var/mob/M)

	for(var/k in all_menus)
		var/menu/E = all_menus[k]
		E.cache_resources(M)

	return TRUE

/proc/open_menu(var/mob/M,var/menu_id)
	spawn
		var/menu/E = SSmenu.all_menus[menu_id]
		E.open(M)

/proc/close_menu(var/mob/M,var/menu_id)
	spawn
		var/menu/E = SSmenu.all_menus[menu_id]
		E.close(M)

proc/get_menu(var/menu_id)
	return SSmenu.all_menus[menu_id]

/proc/send_load(var/mob/M,menu_id) //A common command I use every time I visit your mom.
	var/menu/E = SSmenu.all_menus[menu_id]
	if(!E)
		log_error("Warning: Could not load menu [menu_id ? menu_id : "NULL"] for [M.get_debug_name()]!")
		return FALSE
	E.on_load(M)