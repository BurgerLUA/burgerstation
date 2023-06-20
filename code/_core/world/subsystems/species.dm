
SUBSYSTEM_DEF(species)
	name = "Chargen Subsystem"
	desc = "Basically allows the chargen system not to be dumb."
	priority = SS_ORDER_FIRST
	var/list/all_species = list() //Assoc list.

	var/list/all_hair_files = list()

/subsystem/species/Initialize()

	var/list/hair_files_to_generate = list()
	for(var/k in subtypesof(/species/))
		var/species/S = k
		var/s_id = initial(S.id)
		if(s_id)
			S = new k
			all_species[s_id] = S
			if(S.default_icon_hair)
				hair_files_to_generate += S.default_icon_hair
			if(S.default_icon_hair_face)
				hair_files_to_generate += S.default_icon_hair_face
			var/file_to_check = "text/species/[s_id].txt"
			if(fexists(file_to_check))
				S.desc = rustg_file_read(file_to_check)

	for(var/k in hair_files_to_generate)
		if(all_hair_files[k])
			continue
		var/list/found_icon_states = icon_states(k)
		all_hair_files[k] = list()
		for(var/j in found_icon_states)
			if(j)
				all_hair_files[k] += j

	log_subsystem(name,"Initialized [length(all_species)] species.")

	return ..()
