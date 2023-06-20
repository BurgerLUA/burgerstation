/event/objective
	name = "Bonus Objective"

	probability = 10 //relative

	occurances_max = 2

	var/list/possible_objectives = list(
		/objective/artifact = 100,
		/objective/kill_boss = 25
	)

/event/objective/on_start()
	var/gamemode/G = SSgamemode.active_gamemode

	if(!G)
		return FALSE

	if(!length(possible_objectives))
		occurances_max = 0
		return FALSE

	while(TRUE)
		CHECK_TICK(25,FPS_SERVER*5)
		var/chosen_objective = pickweight(possible_objectives)
		if(G.add_objective(chosen_objective))
			break
		possible_objectives -= chosen_objective

	. = ..()

