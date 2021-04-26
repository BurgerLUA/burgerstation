/vote/virtual_reality //Vote instance
	name = "Virtual Reality Vote" //The name of the vote. Usually the question.
	options = list() //Just a list of possible choices.
	time_limit = 120 //In seconds.

	var/list/vr_name_to_type = list()
	weighted_mode = TRUE


/vote/virtual_reality/New()

	for(var/k in SSvirtual_reality.virtual_reality_programs)
		var/virtual_reality/VR = k
		var/vr_name = initial(VR.name)
		options += vr_name
		vr_name_to_type[vr_name] = VR

	. = ..()


/vote/virtual_reality/on_result(var/winner,var/list/results)

	if(winner)
		SSvirtual_reality.set_virtual_reality(vr_name_to_type[winner])
		SSgamemode.set_active_gamemode(/gamemode/endless/virtual_reality,"voting on_result")

	return TRUE