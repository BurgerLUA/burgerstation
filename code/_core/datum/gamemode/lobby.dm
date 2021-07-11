/gamemode/lobby
	name = "Lobby"
	desc = "The lobby gamemode. You shouldn't be seeing this."
	hidden = TRUE

	round_time_next = 0

/gamemode/lobby/New()
	. = ..()
	round_time_next = 30

/gamemode/lobby/on_life()

	if(state == GAMEMODE_WAITING && round_time_next > 0 && round_time >= round_time_next)
		SSgamemode.set_active_gamemode(/gamemode/endless,"voting on_result")

	/*
	if(state == GAMEMODE_WAITING && round_time_next > 0 && round_time >= round_time_next)
		//world.sleep_offline = FALSE
		if(vr_maps[SSdmm_suite.map_name])
			SSvote.create_vote(/vote/virtual_reality)
		else
			SSvote.create_vote(/vote/gamemode)
		round_time_next = -1
	*/

	return ..()