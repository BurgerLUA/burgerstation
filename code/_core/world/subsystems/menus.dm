var/global/list/menu/all_menus = list()

/subsystem/menus/
	name = "Menu Subsystem"
	desc = "Stores all the known menus in a list."
	priority = SS_ORDER_MENUS

/subsystem/menus/on_life()

	for(var/t in subtypesof(/menu/))
		var/menu/M = new t
		if(M.id)
			all_menus[M.id] = M

	return FALSE