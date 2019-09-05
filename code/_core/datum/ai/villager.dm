/ai/villager
	name = "Passive AI"
	desc = "Does not attack unless provoked. Usually very slow."

	roaming_distance = 3

	objective_delay = 20
	attack_delay = 1000
	movement_delay = SECONDS_TO_DECISECONDS(5)

	target_distribution = list(32)

	simple = TRUE
	sync_movement_delay = TRUE
	stationary = FALSE


/ai/villager/on_life()

	if(!is_turf(owner.loc))
		return TRUE

	movement_ticks += 1
	if(movement_ticks >= movement_delay)
		handle_movement()

	return TRUE

/ai/villager/handle_attacking() //They do not need to attack.
	return FALSE


/ai/villager/handle_movement()

	owner.move_dir = 0

	var/list/valid_directions = list(NORTH,EAST,SOUTH,WEST)

	var/turf/N = get_step(owner,NORTH)
	var/turf/E = get_step(owner,EAST)
	var/turf/S = get_step(owner,SOUTH)
	var/turf/W = get_step(owner,WEST)

	//N
	if(get_dist(N,start_turf) > roaming_distance)
		valid_directions -= NORTH
	else
		for(var/atom/A in N.contents)
			if(is_mob(A) || is_mob_blocker(A))
				valid_directions -= NORTH
				break

	if(get_dist(E,start_turf) > roaming_distance)
		valid_directions -= EAST
	else
		for(var/atom/A in E.contents)
			if(is_mob(A) || is_mob_blocker(A))
				valid_directions -= EAST
				break

	if(get_dist(S,start_turf) > roaming_distance)
		valid_directions -= SOUTH
	else
		for(var/atom/A in S.contents)
			if(is_mob(A) || is_mob_blocker(A))
				valid_directions -= SOUTH
				break

	if(get_dist(W,start_turf) > roaming_distance)
		valid_directions -= WEST
	else
		for(var/atom/A in W.contents)
			if(is_mob(A) || is_mob_blocker(A))
				valid_directions -= WEST
				break

	if(length(valid_directions))
		owner.move_dir = pick(valid_directions)


	movement_ticks = 0