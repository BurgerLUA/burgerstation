SUBSYSTEM_DEF(hair)
	name = "Hair Subsystem"
	desc = "Yes, there is a fucking subsystem dedicated to hair."
	priority = SS_ORDER_PRELOAD

/subsystem/hair/Initialize()

	for(var/s_id in all_species)

		var/species/S = all_species[s_id]

		if(S.default_icon_hair)
			for(var/k in icon_states(S.default_icon_hair))

				if(!k || k=="")
					continue

				S.all_hair_head += k


			LOG_SERVER("Initialized [length(S.all_hair_head)] hairstyles for [S.name].")

		if(S.default_icon_face)
			for(var/k in icon_states(S.default_icon_face))

				if(!k || k == "")
					continue

				S.all_hair_face += k

			LOG_SERVER("Initialized [length(S.all_hair_face)] beardstyles for [S.name].")