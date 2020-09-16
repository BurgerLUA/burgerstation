/dialogue/npc/mech_fabricator/

/dialogue/npc/mech_fabricator/get_dialogue_options(var/mob/living/advanced/player/P,var/list/known_options)

	var/list/dialogue_options = list()


	dialogue_options["hello"] = list(
		"Welcome to NanoTrasen's Automated Mech Fabricator System v0.1 Alpha. You have been automatically recognized as [P.real_name]. Please select one of the following valid commands:NEWLINE\
		#1NEWLINE\
		#2NEWLINE\
		#3NEWLINE\
		#4",
		"*create new mech",
		"*load existing mech",
		"*about"

	)

	dialogue_options["*about"] = list(
		"NanoTrasen's Automated Mech Fabricator System v0.1 Alpha will help you with all the paperwork required to licence and insure your very own multi-purpose mech!NEWLINE\
		To get started with licencing and insurance, head to the #1 and #2. There is a 5000 fee for creating your own mech. If you already have a mech from a previous shift, \
		it is possible to #3 from the system for a 1000 credit fee. Note that once retrieved on a shift, it cannot be re-retrieved or stored until the end of the shift by \
		our advanced retrival team.",
		"*main menu",
		"*create new mech",
		"*load existing mech"
	)

	dialogue_options["*main menu"] = dialogue_options["hello"]

	dialogue_options["*create new mech"] = list(
		"Are you sure you wish to register a new mech? This process will cost 5000 credits.NEWLINE\
		#1NEWLINE\
		#2",
		"*Yes, make new mech.",
		"*No, I do not want a new mech."
	)

	dialogue_options["*load existing mech"] = list(
		"Are you sure you wish to load a previously stored mech? This process will cost 1000 credits.NEWLINE\
		#1NEWLINE\
		#2",
		"*Yes, load my mech.",
		"*No, do not load my mech."
	)

	dialogue_options["*Yes, load my mech."] = list(
		"Your mech is now retrieved from station's storage. Please pick it up at the conveyor!"
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