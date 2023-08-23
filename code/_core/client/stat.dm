/client/Stat()

	if(src.mob)
		statpanel("Game Info")
		var/revision_string
		if(SSlogging.commit == SSlogging.origin_commit)
			revision_string = SSlogging.commit
		else
			revision_string = "[SSlogging.commit]([SSlogging.origin_commit]"
		var/game_info = "Round ID: [SSlogging.round_id ? SSlogging.round_id : "NULL"]\nBuild [SSlogging.version]\nRevision: [revision_string])"
		if(SSgamemode && SSgamemode.initialized && SSgamemode.active_gamemode)
			game_info = "[game_info]\n[SSgamemode.active_gamemode.objective_text]"
		else
			game_info = "[game_info]\nNo objectives found."
		stat(game_info)

	return TRUE