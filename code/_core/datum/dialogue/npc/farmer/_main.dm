/dialogue/npc/farmer/
	name = "Crundus Bundus"
	id = "farmer_dialogue"

/dialogue/npc/farmer/get_dialogue_options(var/mob/living/advanced/player/P,var/list/known_options)

	var/list/dialogue_options = list()



	if(P.species == "human")
		switch(P.sex)
			if(MALE)
				dialogue_options["hello"] = list(
					"What 'chu want, boy?",
				)
			if(FEMALE)
				dialogue_options["hello"] = list(
					"What 'chu want, woman?",
				)

		dialogue_options["realm"] = list(
			"Some foreigner place ran by filthy socialist alien commies. I killed a lot of 'em in the War of 2497.",
		)

		dialogue_options["cultists"] = list(
			"Bunch of xeno-lovers, I say. They've get'n here, I'll find a way to kill 'em.",
		)

		dialogue_options["weapons"] = list(
			"You lookin' to #1? I sell 'em for #2.",
			"barter",
			"trinkets"
		)

		dialogue_options["armor"] = list(
			"You lookin' to #1? I sell 'em for #2.",
			"barter",
			"trinkets"
		)

		dialogue_options["trinkets"] = list(
			"What? Trinkets? Oh those things. Give me some of that old america stuff. Or human stuff. I need more of those. Will give you good #1 and #2 for them.",
			"weapons",
			"armor"
		)


	else
		dialogue_options["hello"] = list(
			"I don't speak to aliens. Go bother that lizard alien woman.",
		)

		dialogue_options["cultists"] = list(
			"You one of 'em? I'm not afraid to kill you, alien.",
		)

		dialogue_options["weapons"] = list(
			"Weapons shouldn't concern you, alien. You've plenty of ways already of causin' damage 'ere.",
		)

		dialogue_options["armor"] = list(
			"I'm not sellin' my armor to you, xeno.",
		)

		dialogue_options["barter"] = list(
			"I don't barter with aliens. Go find someone else of your kind.",
		)

		dialogue_options["trinkets"] = list(
			"I done wan't none of your trinkets, xeno. Go find someone else to barter with.",
		)

	dialogue_options["the mayor"] = list(
		"That filthy alien goes to hide in #1 to perform cult rituals, I tell you. You'd be smart to stay away from that fool.",
		"the caves"
	)

	dialogue_options["the mayor"] = list(
		"There are plenty of caves around here. Go get lost in one, for all I care."
	)

	dialogue_options["wishgranter"] = list(
		"Some bright magic thing that makes you lesbian or somethin'. Stay away from it if you know what's good for you.",
	)

	dialogue_options["Ilaeza Marwani"] = list(
		"Some filthy alien devil temptress or somethin'. I've seen her take #1 off of men AND women.",
		"stolen clothes"
	)

	dialogue_options["stolen clothes"] = list(
		"That lizard temptress takes clothes off the backs of humans and gives 'em to that illumanati folk in #1. It ain't right that them alien kind steal our women and souls and clothes.",
		"bank"
	)

	dialogue_options["the bank"] = list(
		"Yeah where them illumanti hold all the power. They've don't have credits 'ere so they steal clothes to barter with the devils. It's an evil world, I tell ya."
	)

	return dialogue_options
