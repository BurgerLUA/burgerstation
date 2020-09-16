SUBSYSTEM_DEF(vote)
	name = "Voting Subsystem"
	desc = "Controls voting timers and other memes."
	priority = SS_ORDER_TURFS
	tick_rate = SECONDS_TO_TICKS(1)

	cpu_usage_max = 100
	tick_usage_max = 100

	var/list/active_votes = list()

/subsystem/vote/on_life()

	for(var/k in active_votes)
		var/vote/V = k
		if(V.time_to_end > world.time)
			continue
		active_votes -= V
		qdel(V)

	return ..()

/subsystem/vote/proc/create_vote(var/vote/desired_vote_type)
	var/vote/V = new desired_vote_type
	active_votes += V
	V.time_to_end = world.time + SECONDS_TO_DECISECONDS(V.time_limit)
	return V