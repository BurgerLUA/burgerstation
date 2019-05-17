var/global/list/menu/all_menus = list()

/subsystem/menus/
	name = "Menu Subsystem"
	desc = "Stores all the known menus in a list."
	priority = SS_ORDER_NORMAL

/subsystem/menus/Initialize()

	for(var/t in subtypesof(/menu/))
		var/menu/M = new t
		if(M.id)
			all_menus[M.id] = M

	LOG_SERVER("Initialized [length(all_menus)] menus.")