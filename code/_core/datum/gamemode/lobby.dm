/gamemode/lobby
	name = "Lobby"
	desc = "The lobby gamemode. You shouldn't be seeing this."
	hidden = TRUE

	round_time_next = 0

/gamemode/lobby/New()
	. = ..()
	round_time_next = 60 //Wait 60 seconds after load.

/gamemode/lobby/on_life()

	if(state == GAMEMODE_WAITING && round_time_next > 0 && round_time >= round_time_next)
		SSvote.create_vote(/vote/gamemode)
		round_time_next = -1

	. = ..()