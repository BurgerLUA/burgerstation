
SUBSYSTEM_DEF(species)
	name = "Chargen Subsystem"
	desc = "Basically allows the chargen system not to be dumb."
	priority = SS_ORDER_PRELOAD
	var/list/all_species = list() //Assoc list.

/subsystem/species/Initialize()

	for(var/k in subtypesof(/species/))
		var/species/S = k
		var/s_id = initial(S.id)
		if(s_id)
			S = new k
			all_species[s_id] = S

			if(S.default_icon_hair)
				for(var/v in icon_states(S.default_icon_hair))

					if(!v || v=="")
						continue

					S.all_hair_head += v

				log_subsystem(name,"Initialized [length(S.all_hair_head)] species hairstyles for [S.name].")

			if(S.default_icon_hair_face)
				for(var/v in icon_states(S.default_icon_hair_face))

					if(!v || v == "")
						continue

					S.all_hair_face += v

				log_subsystem(name,"Initialized [length(S.all_hair_face)] species beardstyles for [S.name].")

			var/file_to_check = "text/species/[s_id].txt"
			if(fexists(file_to_check))
				S.desc = file2text(file_to_check)
				log_subsystem(name,"Found species description file for [S.name].")

	log_subsystem(name,"Initialized [length(all_species)] species.")

	return ..()
