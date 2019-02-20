var/global/list/all_living = list()

/mob/living/
	var/list/experience/attribute/attributes
	var/list/experience/skill/skills
	var/list/faction/factions
	var/list/starting_factions = list()

	var/starting_class = "default"

	var/list/health_elements

	var/ai/ai

	mouse_over_pointer = MOUSE_ACTIVE_POINTER

	var/status = 0 //Negative status

	var/stun_time = 0 //Deciseconds of stun
	var/sleep_time = 0 //Decieconds of sleep
	var/paralyze_time = 0 //Decieconds of paralyze

	var/first_life = TRUE

	var/stamina_max = 0
	var/stamina_current = 0
	var/stamina_regeneration = 0

	var/mana_max = 0
	var/mana_current = 0
	var/mana_regeneration = 0

/mob/living/New(loc,desired_client)
	. = ..()
	attributes = list()
	skills = list()
	factions = list()
	health_elements = list()

	initialize_attributes()
	initialize_skills()

	all_living += src

	if(ai)
		ai = new ai(src)

/mob/living/Initialize()
	initialize_factions()
	update_health()
	stamina_current = stamina_max
	mana_current = mana_max
	..()

/mob/living/proc/initialize_factions()
	for(var/k in starting_factions)
		factions[k] = all_factions[k]

/mob/living/proc/initialize_attributes()

	var/class/C = all_classes[starting_class]

	for(var/v in all_attributes)
		var/experience/attribute/A = new v(src)
		A.Initialize(A.level_to_xp(C.attributes[A.id]))
		attributes[A.id] = A

/mob/living/proc/initialize_skills()

	var/class/C = all_classes[starting_class]

	for(var/v in all_skills)
		var/experience/skill/S = new v(src)
		S.Initialize(S.level_to_xp(C.skills[S.id]))
		skills[S.id] = S