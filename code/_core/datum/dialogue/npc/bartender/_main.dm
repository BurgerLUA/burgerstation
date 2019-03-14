/dialogue/npc/bartender/
	name = "Miss Flanagan"
	id = "bartender_dialogue"

/dialogue/npc/diamond/get_dialogue_options(var/mob/living/advanced/player/P)

	var/list/dialogue_options = list()

	dialogue_options["hello"] = list(
		"#1 at your service. Want a #2? You look like you could use some #3.",
		"Miss Flanagan",
		"drink",
		"humanity"
	)

	dialogue_options["drink"] = list(
		"Yeah, we provide drink. The #1 and #2 is free. I trade #3 for #4. What do you want?",
		"beer",
		"water",
		"the good stuff",
		"trinkets"
	)

	dialogue_options["beer"] = list(
		"Limit is one per customer per hour. Enjoy."
	)

	dialogue_options["water"] = list(
		"Limit is one per customer per hour. Enjoy."
	)

	dialogue_options["the good stuff"] = list(
		"Whiskey. Vodka. Cognac. The good stuff. If you have #1, I'll #2 you for them.",
		"trinkets",
		"barter"
	)

	dialogue_options["trinkets"] = list(
		"I long for earth 1970-1990s aesthetic. If you have any, I'd be happy to #1.",
		"barter"
	)

	dialogue_options["the mayor"] = list(
		"The mayor? Was in here for a bit. They drank water while #1 drank some whiskey. Left shortly after.",
		"the banker"
	)

	dialogue_options["the banker"] = list(
		"Yeah. '#1' is their name. Everyone just calls them the banker. Easier that way.",
		"Sir Biggus Buckingham"
	)

	dialogue_options["Sir Biggus Buckingham"] = list(
		"Only cyborg in the village. Works in #1. Can't miss them.",
		"the bank"
	)

	dialogue_options["the bank"] = list(
		"It's the big building in the center of #1. East of that #2. In #3 section.",
		"the village",
		"wishgranter",
		"the upper class"
	)

	dialogue_options["the village"] = list(
		"We manage here. I mean we don't have a good food supply, but the cheap beer and water helps give us #1.",
		"humanity"
	)

	dialogue_options["humanity"] = list(
		"Yeah, apparantly #1, #2, and #3 helps us with keeping our humanity. Prevents us from going feral or somethin'. Could be a load of shit, I can't really complain because it makes people #4 with me so...",
		"food",
		"drink",
		"trinkets"
	)

	dialogue_options["food"] = list(
		"We don't sell food here. In fact, #1 hasn't been able to grow anything for quite a while now. I'm sure #2 could tell you more, he knows most about our history.",
		"the village",
		"the mayor"
	)

	dialogue_options["upper class"] = list(
		"It's the rich looking houses to the east. They have the most wealth due because of worker exploit- Oh Jesus, I'm starting to sound like #1.",
		"Vlad"
	)

	dialogue_options["lower class"] = list(
		"It's the dark brown worn out houses. West side of #1. Just north of here.",
		"the village"
	)

	dialogue_options["Vlad"] = list(
		"Yeah, name is Vlad Checknov-something. Lives in #1 section of the city. He could tell you more about this class bullshit. He gives everyone an earfull.",
		"the lower class"
	)

	return dialogue_options

