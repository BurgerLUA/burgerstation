var/global/list/all_living = list()

/mob/living/
	var/list/experience/attribute/attributes
	var/list/experience/skill/skills
	var/list/faction/factions
	var/list/starting_factions = list()

	var/class = "default"

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

	var/attack_mode = 1

	var/list/attack_left = list(
		list(16,16),
		list(16,16),
		list(16,16),
		list(16,16)

	)

	var/list/attack_right = list(
		list(16,16),
		list(16,16),
		list(16,16),
		list(16,16)
	)

	var/is_sneaking = FALSE

	var/intent = INTENT_HELP

	var/level = 0

/mob/living/proc/get_brute_color()
	return "#FF0000"

/mob/living/proc/get_burn_color()
	return "#444444"

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
	update_stats()
	update_health()
	stamina_current = stamina_max
	mana_current = mana_max
	update_level()
	..()
	if(ai)
		name = "[initial(name)] (lvl. [level])"

/mob/living/proc/initialize_factions()
	for(var/k in starting_factions)
		factions[k] = all_factions[k]

