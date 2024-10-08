/dialogue/npc/barshaleez/

/dialogue/npc/barshaleez/get_dialogue_options(var/mob/living/advanced/player/P,var/list/known_options)

	var/list/dialogue_options = list()

	dialogue_options["hello"] = list(
		"Hm? Need something?"
	)

	dialogue_options["the final message"] = list(
		"So #1 felt the need to disclose my identity to a fresh soul, eh? I guess they're getting really desperate now. Not even that thot #2 knows who I am.NEWLINE\
		Well whatever. I suppose he wants me to help you locate #3?",
		"the mayor",
		"Ilaeza Marwani",
		"The Middleman"
	)

	dialogue_options["The Middleman"] = list("He's the one I relay all my messages to whenever I need to send a message to #1. \
		The Middleman knows the physical #2 at all times, so if anyone knows what happened to the old man, it would be him.",
		"The Old Man",
		"location of The Old Man"
	)

	if(known_options["The Middleman"])

		dialogue_options["Ilaeza Marwani"] = list(
			"Ignore them, if you know what's best for you. They may help you with other things, but with respect to #1, the know nothing.",
			"The Old Man"
		)

		dialogue_options["Bar Shaleez"] = list(
			"Yes, I'm #1. I am responsible for most of the communication outside the village.",
			"The Courier"
		)

		dialogue_options["The Old Man"] = list(
			"I'm not a fan of history, especially here, but apparantly the man was responsible for making things better here. \
			Hard to believe that things were worse than this. #1 really wants to find the #2, though, and with good reason.",
			"the mayor",
			"location of The Old Man"
		)

		dialogue_options["Diamond With Flaw"] = list(
			"He's #1. I don't like calling him that, but that is what everyone else calls him. He was the one responsible for enforcing #2 which is why he's called that.",
			"the laws"
		)

		dialogue_options["the mayor"] = list(
			"I prefer using his real name, #1, rather than his assigned name.",
			"Diamond with Flaw"
		)

		dialogue_options["The Courier"] = list(
			"That is me, yes. It is a title passed down from person to person after a certain time of service. Please call me #1 instead as I wish to keep my occupation secret.",
			"Bar Shaleez"
		)

		dialogue_options["the laws"] = list(
			"While #1 was still around, he would send #2 laws, or rules, that were then communicated to me so #3 could receive and enforce those rules. \
			Things have changed since then, and others have took up the duty after #4 started to succumb to #5.",
			"The Old Man",
			"The Middleman",
			"Diamond with Flaw",
			"Diamond with Flaw",
			"gestalt sickness"
		)

		dialogue_options["gestalt sickness"] = list(
			"#1 doesn't like to talk about it. It's an illness that drives a #2 to insanity. I haven't seen what happens when it occurs, and I don't even know if it's actually real.",
			"Diamond with Flaw",
			"gestalt"
		)

		dialogue_options["location of The Old Man"] = list(
			"You are not the first to ask me of this and you will not be the last. I've told #1 and others the same thing I'm telling you now: I cannot tell you this.NEWLINE\
			In order to know the location of #2, you must first know the #3. \
			Sharing any information related to #4 is explicitly forbidden and one of the reasons why they are still functional today.NEWLINE\
			Return back to #5. Tell him for the last time that I refuse to share this information with you or anyone else in this village. \
			While Diamond is a close friend, the safety of #6 is more important than his #7.",
			"Diamond with Flaw",
			"The Old Man",
			"location of The Middleman",
			"The Middleman",
			"Diamond with Flaw",
			"The Middleman",
			"gestalt sickness"
		)

	else

		dialogue_options["Ilaeza Marwani"] = list(
			"Yeah, that's not me. You're looking for the other green lizard who hangs out around here. You'll find them near the #1.",
			"wishgranter"
		)

		dialogue_options["Bar Shaleez"] = list(
			"Yep. That's me. Bar Shaleez. I'm just loitering here, so don't mind me."
		)

		if(known_options["the final message"])

			dialogue_options["The Old Man"] = list(
				"Eh? Who sent you?."
			)

			dialogue_options["Diamond with Flaw"] = list(
				"Oh. I see now. He wants me to talk about #1, yes?",
				"the final message"
			)

			dialogue_options["the mayor"] = list(
				"The mayor? You mean #1, right?",
				"Diamond with Flaw"
			)

			dialogue_options["The Courier"] = list(
				"What? I don't know what you're talking about. Who sent you?"
			)

		else
			dialogue_options["Diamond with Flaw"] = list(
				"Who? Sorry. Don't know who that is."
			)

			dialogue_options["the mayor"] = list(
				"Do I look like a tour guide? Go bother #1.",
				"Ilaeza Marwani"
			)

			dialogue_options["The Old Man"] = list(
				"Eh? That's just a myth."
			)



	return dialogue_options