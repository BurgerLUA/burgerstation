

SUBSYSTEM_DEF(materials)
	name = "Material Subsystem"
	desc = "Stores material data."
	priority = SS_ORDER_PRELOAD
	var/list/all_materials = list()

/subsystem/materials/Initialize()

	for(var/k in subtypesof(/material/))
		var/material/M = k
		M = new k
		all_materials[M.type] = M

	log_subsystem(name,"Initialized [length(all_materials)] material types.")

	return ..()