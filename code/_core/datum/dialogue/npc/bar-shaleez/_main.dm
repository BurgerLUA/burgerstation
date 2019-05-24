/dialogue/npc/barshaleez/
	name = "Bar-Shaleez"
	id = "bar_shaleez_dialogue"

/dialogue/npc/barshaleez/get_dialogue_options(var/mob/living/advanced/player/P,var/list/known_options)

	var/list/dialogue_options = list()

	dialogue_options["hello"] = list(
		"Yes, I'm talking to you, nerd. Are you trying to #1?",
		"leave the village"
	)


	if(!known_options["_given_money"])
		dialogue_options["leave the village"] = list(
			"HA. Good luck. There are plenty of people like you out there waiting for you to make a mistake and kill you, regardless of how much you beg for your life. \
			You should know this, yes? Have you not spoken to #1? Go find him, and buy yourself some better clothes.NEWLINE\
			(100 #2 have been added to your inventory.)",
			"the mayor",
			"bluespace crystals",
			"_given_money"
		)
	else
		dialogue_options["leave the village"] = list(
			"HA. Good luck. There are plenty of people like you out there waiting for you to make a mistake and kill you, regardless of how much you beg for your life. \
			You should know this, yes? Have you not spoken to #1? Go find him, and buy yourself some better clothes.",
			"the mayor",
			"bluespace crystals",
			"_given_money"
		)

	dialogue_options["bluespace crystals"] = list(
		"What? Those things? Oh, they're what you use for currency here. They're magical, special gems that have some arbitrary value to them, for some reason. You probably guessed it, but it was #1 who introduced the idea of a standardized currency here.",
		"the mayor"
	)

	if(known_options["getting into"])
		dialogue_options["the mayor"] = list(
			"If you really want to talk to him about what you're #1, go find him. Somewhere. He likes to hide out in a cave to the northeast of the village. \
			I honestly wouldn't be suprised if he's with the #2 given the amount of time he spents up there."
		)
	else if(known_options["Diamond with Flaw"])
		dialogue_options["the mayor"] = list(
			"I can tell you talked to him. He leaves a certain... impression on people. Gives people that look on their face. You probably don't know what you're #1, yes?",
			"getting into"
		)
	else
		dialogue_options["the mayor"] = list(
			"I knew it. You never did talk to him! Well that is no matter. They are a little weird and we could use people like you who don't give a lizard's patootie about important things. \
			You're here to have fun, yes? Well fun can really only be had if you know what you're #1, yes?",
			"getting into"
		)

	if(known_options["the rule"])
		dialogue_options["getting into"] = list(
			"This isn't like your previous life where you're protected by shitcurity or the AI. Out here, anyone can kill you for any reason whatsoever and you can do the same to them.. \
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
		"If you wrong someone by death, there is a chance you'll answer to us; #1. \
		Regardless of what sentient species you kill, we'll likely find out and put a bounty on your head we have people watching eveywhere, so don't try to avoid us.",
		"The Bounty Hunters"
	)

	dialogue_options["Bounty Hunters"] = list(
		"We're an organization meant to be a counterbalance to the amount of shitters that come in this realm to fuck people up for the sake of fucking people up. \
		We're not zealots in a sense where we want total peace, we just hate kids who ruin other's attempt at an escape from this realm. We're always looking for members to #1.",
		"join the Bounty Hunters"
	)

	dialogue_options["join the Bounty Hunters"] = list(
		"You wish to join the Bounty Hunters? Uh... no. Not yet, anyways. Prove your use to us, and we'll approach you."
	)

	return dialogue_options