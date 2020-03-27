var/global/list/experience/skill/all_skills = list()

SUBSYSTEM_DEF(skills)
	name = "Skill Subsystem"
	desc = "Stores all the known skills in a list."
	priority = SS_ORDER_PRELOAD

/subsystem/skills/Initialize()
	for(var/A in subtypesof(/experience/skill/))
		all_skills += A

	log_subsystem(name,"Initialized [length(all_skills)] skills.")