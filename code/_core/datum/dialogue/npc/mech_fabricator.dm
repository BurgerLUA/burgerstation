/dialogue/npc/mech_fabricator/

/dialogue/npc/mech_fabricator/get_dialogue_options(var/mob/living/advanced/player/P,var/list/known_options)

	var/list/dialogue_options = list()


	dialogue_options["hello"] = list(
		"Welcome to NanoTrasen's Automated Mech Fabricator System v0.1 Alpha. You have been automatically recognized as [P.real_name]. Please select one of the following valid commands:NEWLINE\
		#1NEWLINE\
		#2NEWLINE\
		#3NEWLINE\
		#4",
		"*create new mech"
	)

	dialogue_options["*main menu"] = dialogue_options["hello"]

	dialogue_options["*create new mech"] = list(
		"Are you sure you wish to register a new mech? This process will cost 2000 credits.NEWLINE\
		#1NEWLINE\
		#2",
		"*Yes, make new mech.",
		"*No, I do not want a new mech."
	)

	dialogue_options["*Yes, make new mech."] = list(
		"Your mech is now created and registered to the system. Please pick it up at the conveyor!"
	)


	return dialogue_options
/*
/dialogue/npc/mech_fabricator/set_topic(var/mob/living/advanced/player/P,var/topic)

	. = ..()

	switch(topic)


	return .
*/