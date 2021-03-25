/dialogue/npc/master/

/dialogue/npc/master/get_dialogue_options(var/mob/living/advanced/player/P,var/list/known_options)

	. = list()

	.["hello"] = list(
		"Welcome to the #1. Are you here to be recruited into our #2?",
		"*Recruitment Office",
		"*Prestige Program"
	)

	.["*Recruitment Office"] = list(
		"This here is the recruitment office. This is where we recruit extraordinary NanoTrasen Operatives for use in special programs, like the #1. Are you interested in such?",
		"*Prestige Program"
	)

	.["*Prestige Program"] = list(
		"The Prestige Program, or PP for short, is an experimental and questionably legal brain surgery procedure that alters certain areas of the brain to be more compact \
		to allow a broader understanding of the subject. As a consequence, you'll have to relearn everything you know, but once you've done so, you'll be smarter in the subject matter! NEWLINENEWLINE\
		So, are you ready to be a part of the Prestige Program? Only masters of a skill can participate! NEWLINENEWLINE\
		#1 NEWLINE\
		#2",
		"*Yes, enter the prestige program",
		"*No, do not enter the prestige program"
	)

	.["*No, do not enter the prestige program"] = list("That's a shame. You can enter the program at any time you wish.")

	.["*Yes, enter the prestige program"] = list("...")



/dialogue/npc/master/set_topic(var/mob/living/advanced/player/P,var/topic)

	. = ..()

	if(topic == "*Yes, enter the prestige program")
		P.dialogue_target_id = null
		close_menu(P,/menu/dialogue/)
		spawn try_prestige(P)

/dialogue/npc/master/proc/try_prestige(var/mob/living/advanced/player/P)

	var/list/valid_skills = list()

	for(var/k in P.skills)
		var/experience/E = P.skills[k]
		if(E.get_max_level() > E.get_current_level())
			continue
		valid_skills += E

	if(!length(valid_skills))
		P.to_chat(span("warning","You have no valid skills to prestige! Come back when one of your skills is above the prestige threshold."))
		return FALSE

	valid_skills += "Cancel"

	var/desired_choice = input("Are you sure you wish to enter the prestige program? The chosen skill will be reset to 5 and its max level will increase by 5.","Prestige Program","Cancel") as null|anything in valid_skills
	if(!desired_choice || desired_choice == "Cancel")
		P.to_chat(span("notice","You decide not to prestige anything."))
		return FALSE

	var/experience/E = desired_choice
	if(E.get_max_level() <= E.get_current_level())
		P.prestige(E.id)
	return TRUE