SUBSYSTEM_DEF(language)
	name = "Language Subsystem"
	desc = "Controls languages."
	priority = SS_ORDER_FIRST
	var/list/all_languages = list()

	var/language_seed = 1337

/subsystem/language/Initialize()

	for(var/k in subtypesof(/language/))
		var/language/L = k
		var/id = initial(L.id)
		if(id)
			L = new k
			all_languages[id] = L

	log_subsystem(name,"Initialized [length(all_languages)] languages.")

	return ..()