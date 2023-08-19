/client/Stat()

	if(src.mob)
		statpanel("Game Info")
		var/game_info = "Round ID: [SSlogging.round_id ? SSlogging.round_id : "NULL"]\nServer Revision: [SSlogging.commit]([SSlogging.origin_commit])"
		if(SSgamemode && SSgamemode.initialized && SSgamemode.active_gamemode)
			game_info = "[game_info]\n[SSgamemode.active_gamemode.objective_text]"
		else
			game_info = "[game_info]\nNo objectives found."
		stat(game_info)

	return TRUE