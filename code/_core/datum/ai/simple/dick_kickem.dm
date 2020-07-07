/ai/dick_kickem/

	target_distribution_x = list(16)
	target_distribution_y = list(11)

	var/next_talk = 0

/ai/dick_kickem/handle_attacking()

	if(objective_attack && next_talk <= world.time)
		var/message_to_say = list(
			"SOME PEOPLE CALL ME AN ASSHOLE. IT'S BECAUSE THERE IS A HOLE IN MY ASS.",
			"YEAH YOU KEEP SHITTING YOURSELF.",
			"I'M JUST ANOTHER HUGE FAT BITCH IN A SEA OF GAMERS.",
			"OH, YOU THINK YOU'RE HOT SHIT?",
			"ANIME? MORE LIKE HAVE TO PEE.",
			"IT'S TIME TO GET NUDE AND BE OUTDOORS.",
			"I'M HERE TO KICK.",
			"IT'S TIME TO ASS.",
			"I'M DICK KICKEM.",
			"I'M GOING TO MAINTAIN AN ERECTION.",
			"I'M GOING TO RIP OFF YOUR HEAD AND FAINT AT THE SIGHT OF BLOOD.",
			"THOSE DAMN ALIEN BASTARDS FUCKED MY CAR."
		)
		owner.do_say(pick(message_to_say),FALSE)

		next_talk = world.time + SECONDS_TO_DECISECONDS(6)

	return ..()