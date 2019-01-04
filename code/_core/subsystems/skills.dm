var/global/list/experience/skill/all_skills = list()

/datum/subsystem/skills/
	name = "Skill Subsystem"
	desc = "Stores all the known skills in a list."
	priority = SS_ORDER_SKILLS

/datum/subsystem/skills/on_life()

	for(var/A in subtypesof(/experience/skill/))
		all_skills += A

	return FALSE