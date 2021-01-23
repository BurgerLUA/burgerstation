/vote/map //Vote instance
	name = "Map Vote" //The name of the vote. Usually the question.
	options = list() //Just a list of possible choices.
	time_limit = 30 //In seconds.

/vote/map/New()

	for(var/k in horde_maps)
		options += k

	return ..()


/vote/map/on_result(var/winner,var/list/results)

	if(!winner)
		broadcast_to_clients(span("danger","Vote failed! Defaulting to Island..."))
		winner = "Island"

	rustg_file_write(winner,NEXT_MAP_FILE)

	return TRUE