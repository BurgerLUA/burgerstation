/vote/continue_round //Vote instance
	name = "Continue the Round?" //The name of the vote. Usually the question.
	options = list("Yes","No") //Just a list of possible choices.
	time_limit = 60 //In seconds.


/vote/continue_round/on_result(var/winner,var/list/results)

	if(winner == "No")
		world.end(WORLD_END_NANOTRASEN_VICTORY)
	else
		SSgamemode.active_gamemode.on_continue()

	return TRUE