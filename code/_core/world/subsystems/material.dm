var/global/list/all_materials = list()

SUBSYSTEM_DEF(materials)
	name = "Material Subsystem"
	desc = "Stores material data."
	priority = SS_ORDER_PRELOAD

/subsystem/materials/Initialize()

	for(var/k in subtypesof(/material/))
		var/material/M = k
		var/id = initial(M.id)
		if(id)
			M = new k
			all_materials[id] = M

	return TRUE