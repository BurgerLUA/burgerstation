/savedata/client/mob
	name = "Mob Save Data"

/savedata/client/mob/get_folder()
	return replacetext(CKEY_PATH,"%CKEY",owner.ckey)

/savedata/client/mob/reset_data()
	loaded_data = list(
		"name" = "Urist McRobust",
		"tutorial" = 1,
		"id" = "none",
		"last_saved_date" = 0,
		"last_saved_time" = 0,
		"organs" = list(),
		"worn" = list(),
		"held" = list(),
		"skills" = list(),
		"attributes" = list(),
		"karma" = list(
			KARMA_HUMAN = 1000,
			KARMA_LIZARD = 1000,
			KARMA_CYBORG = 1000,
			KARMA_DIONA = 1000
		),
		"last_save" = "village",
		"known_topics" = list()
	)


/savedata/client/mob/New(var/client/new_owner)

	..()

	reset_data()

	owner = new_owner

	if(!has_character())
		owner << "Welcome to Burgerstation!"
	else
		owner << "Welcome back to Burgerstation!"
		loaded_data = load_most_recent_character()
		owner.save_slot = loaded_data["id"]