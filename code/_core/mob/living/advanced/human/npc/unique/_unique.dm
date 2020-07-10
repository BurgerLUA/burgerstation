/mob/living/advanced/npc/unique/
	ai = null
	move_mod = 1


/mob/living/advanced/npc/unique/setup_name()

	if(name == DEFAULT_NAME) //Give a human name
		name = "[gender == MALE ? FIRST_NAME_MALE : FIRST_NAME_FEMALE] [LAST_NAME]"

	real_name = name

	return TRUE