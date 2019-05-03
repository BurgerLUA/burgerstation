/dialogue/npc/barshaleez/
	name = "Bar-Shaleez"
	id = "bar_shaleez_dialogue"

/dialogue/npc/barshaleez/get_dialogue_options(var/mob/living/advanced/player/P,var/list/known_options)

	var/list/dialogue_options = list()

	dialogue_options["hello"] = list(
		"Yes, I'm talking to you, nerd. Are you trying to #1?",
		"leave the village"
	)

	dialogue_options["leave the village"] = list(
		"HA. Good luck. There are plenty of people like you out there waiting for you to make a mistake and kill you, regardless of any penalties. Have you talked to #1 yet?",
		"the mayor"
	)

	if(known_options["getting into"])
		dialogue_options["the mayor"] = list(
			"If you really want to talk to him about what you're #1, go find him. Somewhere. He likes to hide out in a cave to the northeast of the village. \
			I honestly wouldn't be suprised if he's with the #2 given the amount of time he spents up there."
		)
	else if(known_options["Diamond with Flaw"])
		dialogue_options["the mayor"] = list(
			"I can tell you talked to him. He leaves a certain... impression on people. Fives people that look on their face. You probably don't know what you're #1, yes?",
			"getting into"
		)
	else
		dialogue_options["the mayor"] = list(
			"HA. I knew it. You never did talk to him! Well that is no matter. They are a little weird and we could use people like you who don't give a lizard's patootie about important things. \
			You're here to have fun, yes? Well fun can really only be have if you know what you're #1, yes?",
			"getting into"
		)

	if(known_options["the rule"])
		dialogue_options["getting into"] = list(
			"This isn't like your previous life where you're protected by shitcurity or the AI. Out here, anyone can kill you for any reason whatsoever and you can do the same to them. \
			On a normal day, #1 probably told you about #2, or not. Depends what mood they're in. Long story short, if you want to kill people, just be prepared to #3, if there are any even to begin with.",
			"the mayor",
			"the rule",
			"face the consequences"
		)
	else
		dialogue_options["getting into"] = list(
			"This isn't like your previous life where you're protected by shitcurity or the AI. Out here, anyone can kill you for any reason whatsoever and you can do the same to them. \
			On a normal day, #1 probably told you this, or not. Depends what mood they're in. Long story short, if you want to kill people, just be prepared to #2, if there are any even to begin with.",
			"the mayor",
			"face the consequences"
		)

	var/protected_text

	switch(protected_species)
		if(RULE_HUMAN)
			protected_text = "humans"

	if(known_options["wraith of Nar-sie"])
		if(protected_text == "humans")
			dialogue_options["the rule"] = list(
				"Diamond told you about the rule? Well they probably gave you a very basic understanding of it. It doesn't quite work like you think it does. \
				You're not allowed to kill GOOD humans. You can kill evil humans, but just not good humans... which is odd for this realm, yes, but that's just how it goes. \
				Good humans are basically humans who do not harm people for the sake of harming people. These are ones who do not go out of there way to kill people. \
				The evil ones, on the other hand, are. They're the ones who kill humans regardless if those people need killing."
			)
		else
			//WIP. This is for a future update after it's released.
			dialogue_options["the rule"] = list(
				"Diamond told you about the rule? Well they're wrong. They've been living in that cave for so long they've missed quite a bit of changes to this realm. \
				They likely told you that you shouldn't go around killing humans, yes? If so, yes. They're wrong."
			)

	else
		dialogue_options["the rule"] = list(
			"The rule is this: Don't kill non-evil [protected_text]."
		)


	dialogue_options["face the consequences"] = list(
		"If you wrong someone, there is a chance you'll answer to us; #1. Regardless of what species you kill, we'll likely find out and put a bounty on your head. \
		We don't do it out of the kindness of our hearts, but as an excuse to kill people. Turns out "
	)



	return dialogue_options