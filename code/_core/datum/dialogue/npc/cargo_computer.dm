/dialogue/npc/cargo_computer/

/dialogue/npc/cargo_computer/get_dialogue_options(var/mob/living/advanced/player/P,var/list/known_options)

	. = list()

	.["hello"] = list(
		"Welcome to NanoTrasen's Cargo Ordering System v0.1 Alpha. You have been automatically recognized as [P.real_name]. Please select one of the following valid commands:NEWLINE\
		#1NEWLINE\
		#2NEWLINE\
		#3",
		"*purchase requisition sheet",
		"*purchase catalogue",
		"*about"

	)

	.["*about"] = list(
		"NanoTrasen's Cargo Ordering System v0.1 Alpha will help you purchase everything you need in order to complete your mission in the current mission area. \
		To order something from the cargo system, purchase a requisition sheet and fill out the information of the item you wish to aquire in the Cargo catalogue. \
		Once you are done, process the requisition via the fax machine located outside cargo. Your order will be placed and can be picked up at the secondary cargo shuttle.NEWLINE\
		To purchase a template requisition sheet, select \"#1\".NEWLINE\
		To purchase an updated catalog, select \"#2\".NEWLINE\
		To view this about page again, select \"#3\".",
		"*purchase requisition sheet",
		"*purchase catalogue",
		"*about"
	)

	.["*main menu"] = .["hello"]

	.["*purchase requisition sheet"] = list(
		"Are you sure you wish to purchase a template requisition sheet? This operation will cost 50 credits.NEWLINE\
		#1NEWLINE\
		#2",
		"*Yes, purchase a requisition sheet.",
		"*No, do not purchase a requisition sheet."
	)

	.["*purchase catalogue"] = list(
		"Are you sure you wish to purchase an up to date cargo catalogue? This operation will cost 200 credits.NEWLINE\
		#1NEWLINE\
		#2",
		"*Yes, purchase a catalogue.",
		"*No, do not purchase a catalogue."
	)


	.["*Yes, purchase a requisition sheet."] = list(
		"You have selected to purchase a requisition sheet. Please return to the #1.",
		"*main menu"
	)

	.["*Yes, purchase a catalogue."] = list(
		"You have selected to purchase a catalogue. Please return to the #1.",
		"*main menu"
	)

	.["*No, do not purchase a requisition sheet."] = list(
		"You have selected not to purchase a requisition sheet. Please return to the #1.",
		"*main menu"
	)

	.["*No, do not purchase a catalogue."] = list(
		"You have selected not to purchase a catalogue. Please return to the #1.",
		"*main menu"
	)

/dialogue/npc/cargo_computer/set_topic(var/mob/living/advanced/player/P,var/topic)

	. = ..()

	switch(topic)
		if("*Yes, purchase a requisition sheet.")
			if(P.currency >= 50 && P.adjust_currency(-50))
				var/obj/item/paper/cargo/C = new(get_turf(P))
				INITIALIZE(C)
				GENERATE(C)
				FINALIZE(C)
				P.put_in_hands(C)
			else
				P.to_chat(span("warning","You can't afford that!"))
		if("*Yes, purchase a catalogue.")
			if(P.currency >= 200 && P.adjust_currency(-200))
				var/obj/item/paper/book/cargo_catalog/C = new(get_turf(P))
				INITIALIZE(C)
				GENERATE(C)
				FINALIZE(C)
				P.put_in_hands(C)
			else
				P.to_chat(span("warning","You can't afford that!"))

