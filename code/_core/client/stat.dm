client/Stat()

	while(!update_stats)
		sleep(SECONDS_TO_DECISECONDS(1))

	statpanel("Skills")
	if(src.mob && is_living(src.mob))
		var/mob/living/L = src.mob
		for(var/experience/skill/S in L.skills)
			stat(S.name, S.get_current_level())

	statpanel("Attributes")
	if(src.mob && is_living(src.mob))
		var/mob/living/L = src.mob
		for(var/experience/attribute/A in L.attributes)
			stat(A.name, A.get_current_level())

	update_stats = FALSE

	return TRUE