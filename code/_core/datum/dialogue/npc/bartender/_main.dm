/dialogue/npc/bartender/

/dialogue/npc/bartender/get_dialogue_options(var/mob/living/advanced/player/P,var/list/known_options)

	var/list/dialogue_options = list()

	dialogue_options["hello"] = list(
		"#1 at your service. Want a #2? You look like you could use one.",
		"Miss Flanagan",
		"water"
	)

	dialogue_options["Miss Flanagan"] = list(
		"Yep, that's me. Your one and only bartender. I sell #1 to anyone whos asks.",
		"water"
	)

	dialogue_options["water"] = list(
		"Yeah, all we have is water here. I don't have enough supplies to make alcohol here cause the #1 keeps forgeting, so you're going to have to deal with it. All you need is some #2 to buy it.",
		"the mayor",
		"telecrystals"
	)
	if(known_options["secret Syndicate hiding place"])
		dialogue_options["the mayor"] = list(
			"The mayor? Was in here for a bit. Said they went to go talk with #1 before I could tell them about the asshole in the back.",
			"Shopkeeper Eric"
		)
	else
		dialogue_options["the mayor"] = list(
			"The mayor? Was in here for a bit. Said they went to go talk with #1. They might be there.",
			"Shopkeeper Eric"
		)

	dialogue_options["telecrystals"] = list(
		"Oh, you're new here, right? Well instead of using credits or gold or whatever it is now, we use telecrystals in order to trade for #1. #2 used to use them in the real world to teleport goods so I guess that works here too.",
		"goods and services",
		"The Syndicate"
	)

	dialogue_options["The Syndicate"] = list("They're anti-capitalist assassins or something. I don't pay much attention to them, to be honest. Other villagers can tell you about how they have a #1 or something, but it's not really a secret.",
		"secret Syndicate hiding place"
	)

	dialogue_options["secret Syndicate hiding place"] = list(
		"Yeah, some asshole setup shop right next to my bar in the back. They sell overpriced Syndicate goods that only idiots buy. I tried telling #1 about it but he doesn't seem to care.",
		"the mayor"
	)

	dialogue_options["goods and services"] = list(
		"I sell fresh #1 here. Others in this land tend to sell other things here. For example, the #2 sells general goods. Who would've thought?",
		"water",
		"general store"
	)

	dialogue_options["Shopkeeper Eric"] = list(
		"Yeah. 'Shopkeeper Eric' is their name. Obviously fake. He owns the #1 in the center of the village.",
		"general store"
	)

	dialogue_options["general store"] = list(
		"Yeah #1 sells general goods there. It's in the center of the village. You can't miss it.",
		"Shopkeeper Eric"
	)

	return dialogue_options

