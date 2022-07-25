/dialogue/npc/wizard_ambassador/

/dialogue/npc/wizard_ambassador/get_dialogue_options(var/mob/living/advanced/player/P,var/list/known_options)

	. = list()

	.["hello"] = list(
		"GREETINGS. I am #1, ambassador of the #2. Do you come here seeking #3, or are you here to pay your respects to the #2?",
		"Bandalf the Right",
		"Wizard Federation",
		"magic"
	)

	.["Bandalf the Right"] = list(
		"Yes, I have rightfully earned my title of #1 by evading many a #2 in this universe simply by being factually correct at all times. \
		Maybe one day you too will earn a similiar title if one spent as long as I have preserving my identity and soul.",
		"Bandalf the Right",
		"ban"
	)

	.["ban"] = list(
		"Sometimes a cosmic force out of this world may try to come for your very soul, seeking to rip it from your very own mortal coil and claim it for their own. \
		Many a victim fall to this evil force, but one can stave it off by being entirely factual when it calls for your name. The #1 has been working hard with \
		some of NanoTrasen's top #2 scientists to eliminate the threat entirely...",
		"Wizard Federation",
		"Simpleton"
	)

	.["Wizard Federation"] = list(
		"I represent the #1, seeking to spread the knowledge of #2 to all who respect the might of the mighty #1. In recent years, NanoTrase has become one of these \
		might-respectors by sharing their research on avoiding the dreadful #3.",
		"Wizard Federation",
		"magic",
		"ban"
	)

	.["magic"] = list(
		"Ohoho, #1 is our specialty. We seek to spread the knowledge of these ancient arcane arts to as many #2s as possible. \
		We found that we can spread chaos- er I mean corporate profits if we just gave out magic to everyone. \
		You can purchase magic here out of the convenient vendors here. GOLD ONLY, NO CHECKS OR CREDIT!",
		"magic",
		"Simpleton"
	)

	.["Simpleton"] = list(
		"Oh, that is just the incredibly non-offensive name that we give to non-natural #1 users. While you do channel #1 through these gems, \
		we at the #2 don't consider it to be REAL #1 that comes from the SOUL, not the body. We still call it #1 so you all feel better about it!",
		"magic",
		"Wizard Federation"
	)