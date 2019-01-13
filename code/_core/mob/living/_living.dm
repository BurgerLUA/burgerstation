/mob/living/
	var/list/experience/attribute/attributes
	var/list/experience/skill/skills
	var/list/faction/factions
	var/list/starting_factions = list()

	var/ai/ai

/mob/living/New()
	. = ..()
	attributes = list()
	skills = list()
	initialize_attributes()
	initialize_skills()
	factions = list()
	if(ai)
		ai = new(src)

/mob/living/Initialize()
	for(var/k in starting_factions)
		factions[k] = all_factions[k]

	..()