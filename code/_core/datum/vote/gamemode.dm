/vote/gamemode //Vote instance
	name = "Gamemode Vote" //The name of the vote. Usually the question.
	options = list() //Just a list of possible choices.
	time_limit = 60 //In seconds.

	var/list/gamemode_name_to_type = list()
	weighted_mode = TRUE


/vote/gamemode/New()

	for(var/k in SSgamemode.all_gamemodes)
		var/gamemode/G = k
		if(initial(G.hidden))
			continue
		var/game_name = initial(G.name)
		options += game_name
		gamemode_name_to_type[game_name] = G

	//stupid jury rigged shit
	if(findtext(SSdmm_suite.map_name, "Invasion"))
		options -= "Liberation"
		for(var/atom/chungus in join_buttons["become-insurrection"])
			qdel(chungus)
	else if(findtext(SSdmm_suite.map_name, "Liberation"))
		options -= "Invasion"
		for(var/atom/chungus in join_buttons["become-covenant"])
			qdel(chungus)

	return ..()


/vote/gamemode/on_result(var/winner,var/list/results)

	if(winner)
		SSgamemode.set_active_gamemode(gamemode_name_to_type[winner],"voting on_result")
	else
		broadcast_to_clients(span("danger","Vote failed! Defaulting to Liberation..."))

	return TRUE