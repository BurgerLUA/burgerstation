SUBSYSTEM_DEF(language)
	name = "Language Subsystem"
	desc = "Controls languages."
	priority = SS_ORDER_PRELOAD
	var/list/all_languages = list()

/subsystem/language/Initialize()

	for(var/k in subtypesof(/language/))
		var/language/L = k
		var/id = initial(L.id)
		if(id)
			L = new k
			all_languages[id] = L

	log_subsystem(name,"Initialized [length(all_languages)] languages.")

	return ..()