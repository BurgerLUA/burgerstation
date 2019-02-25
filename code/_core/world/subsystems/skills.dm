var/global/list/experience/skill/all_skills = list()

/subsystem/skills/
	name = "Skill Subsystem"
	desc = "Stores all the known skills in a list."
	priority = SS_ORDER_SKILLS

/subsystem/skills/Initialize()
	for(var/A in subtypesof(/experience/skill/))
		all_skills += A