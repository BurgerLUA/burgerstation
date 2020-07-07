SUBSYSTEM_DEF(experience)
	name = "Experience Subsystem"
	desc = "Stores all the known experiences."
	priority = SS_ORDER_PRELOAD

	var/list/all_skills = list()
	var/list/all_attributes = list()

/subsystem/experience/Initialize()

	for(var/k in subtypesof(/experience/skill))
		var/experience/skill/S = k
		var/initial_id = initial(S.id)
		if(S && initial_id)
			all_skills[initial_id] = S

	for(var/k in subtypesof(/experience/attribute))
		var/experience/attribute/A = k
		var/initial_id = initial(A.id)
		if(A && initial_id)
			all_attributes[initial_id] = A

	log_subsystem(name,"Initialized [length(all_skills)] skills.")
	log_subsystem(name,"Initialized [length(all_attributes)] attributes.")

	return ..()