/ai/clown

	aggression = 2
	assistance = 1
	retaliate = TRUE

	var/list/jokes = list()

	var/next_talk = 0

/ai/clown/handle_attacking()

	if(length(jokes) && objective_attack && next_talk <= world.time)
		owner.do_say(pick(jokes),FALSE)
		next_talk = world.time + SECONDS_TO_DECISECONDS(12)

	return ..()


