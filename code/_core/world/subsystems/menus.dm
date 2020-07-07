var/global/list/menu/all_menus = list()

SUBSYSTEM_DEF(menus)
	name = "Menu Subsystem"
	desc = "Stores all the known menus in a list."
	priority = SS_ORDER_PRELOAD

/subsystem/menus/Initialize()

	for(var/t in subtypesof(/menu/))
		var/menu/M = new t
		if(M.id)
			all_menus[M.id] = M

	log_subsystem(name,"Initialized [length(all_menus)] menus.")

	return ..()