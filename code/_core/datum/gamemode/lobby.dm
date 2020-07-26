/gamemode/lobby
	name = "Lobby"
	desc = "The lobby gamemode. You shouldn't be seeing this."
	hidden = TRUE

	round_time_next = 5

/gamemode/lobby/on_life()

	//world.log << "state == GAMEMODE_WAITING: [state == GAMEMODE_WAITING]"
	//world.log << "round_time_next >= 0: [round_time_next >= 0]"
	//world.log << "round_time >= round_time_next: [round_time >= round_time_next]"

	if(state == GAMEMODE_WAITING && round_time_next >= 0 && round_time >= round_time_next)
		SSvote.create_vote(/vote/gamemode/)
		round_time_next = -1

	return ..()