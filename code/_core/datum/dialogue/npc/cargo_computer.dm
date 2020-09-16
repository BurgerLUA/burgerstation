/dialogue/npc/cargo_computer/

/dialogue/npc/cargo_computer/get_dialogue_options(var/mob/living/advanced/player/P,var/list/known_options)

	var/list/dialogue_options = list()


	dialogue_options["hello"] = list(
		"Welcome to NanoTrasen's Cargo Ordering System v0.1 Alpha. You have been automatically recognized as [P.real_name]. Please select one of the following valid commands:NEWLINE\
		#1NEWLINE\
		#2NEWLINE\
		#3",
		"*purchase requisition sheet",
		"*purchase catalogue",
		"*about"

	)

	dialogue_options["*about"] = list(
		"NanoTrasen's Cargo Ordering System v0.1 Alpha will help you purchase everything you need in order to complete your mission in the current mission area. \
		To order something from the cargo system, print a requisition sheet and fill out the information of the item you wish to aquire in the Cargo catalogue. \
		Once you are done, process the requisition via the fax machine located outside cargo. Your order will be placed and can be picked up at the secondary cargo shuttle.NEWLINE\
		To print a template requsition sheet, select \"purchase requisition sheet\".NEWLINE\
		To print an updated catalog, select \"purchase catalog\".NEWLINE\
		To view this about page again, select \"about\".",
		"*print requisition sheet",
		"*purchase catalogue",
		"*about"
	)

	dialogue_options["*main menu"] = dialogue_options["hello"]

	dialogue_options["*purchase requisition sheet"] = list(
		"Are you sure you wish to print a template requisition sheet? This operation will cost 100 credits.NEWLINE\
		#1NEWLINE\
		#2",
		"*Yes, print a requsition sheet.",
		"*No, do not print a requsition sheet."
	)

	dialogue_options["*purchase catalogue"] = list(
		"Are you sure you wish to purchase an up to date catalogue? This operation will cost 200 credits.NEWLINE\
		#1NEWLINE\
		#2",
		"*Yes, purchase a catalogue.",
		"*No, do not purchase a catalogue."
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