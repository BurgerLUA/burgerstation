/client/Stat()

	if(src.mob)
		statpanel("Objectives")
		if(SSgamemode && SSgamemode.initialized && SSgamemode.active_gamemode)
			stat(SSgamemode.active_gamemode.objective_text)
		else
			stat("No objectives found.")

	return TRUE