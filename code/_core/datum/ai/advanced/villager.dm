/ai/advanced/villager
	roaming_distance = 3

/ai/advanced/villager/on_life()

	if(!isturf(owner.loc))
		return TRUE

	return TRUE

/ai/advanced/villager/handle_attacking() //They do not need to attack.
	return FALSE


/ai/advanced/villager/handle_movement()

	owner.move_dir = 0

	for(var/mob/living/advanced/player/P in oview(owner,3))
		if(P)
			owner.set_dir(get_dir(owner,P))
			return TRUE

	if(prob(70))
		return FALSE

	var/list/valid_directions = list(NORTH,EAST,SOUTH,WEST)

	var/turf/N = get_step(owner,NORTH)
	var/turf/E = get_step(owner,EAST)
	var/turf/S = get_step(owner,SOUTH)
	var/turf/W = get_step(owner,WEST)

	//N
	if(get_dist(N,start_turf) > roaming_distance)
		valid_directions -= NORTH
	else
		for(var/k in N.contents)
			var/atom/movable/A = k
			if(ismob(A) || is_mob_blocker(A))
				valid_directions -= NORTH
				break

	if(get_dist(E,start_turf) > roaming_distance)
		valid_directions -= EAST
	else
		for(var/k in E.contents)
			var/atom/movable/A = k
			if(ismob(A) || is_mob_blocker(A))
				valid_directions -= EAST
				break

	if(get_dist(S,start_turf) > roaming_distance)
		valid_directions -= SOUTH
	else
		for(var/k in S.contents)
			var/atom/movable/A = k
			if(ismob(A) || is_mob_blocker(A))
				valid_directions -= SOUTH
				break

	if(get_dist(W,start_turf) > roaming_distance)
		valid_directions -= WEST
	else
		for(var/k in W.contents)
			var/atom/movable/A = k
			if(ismob(A) || is_mob_blocker(A))
				valid_directions -= WEST
				break

	if(length(valid_directions))
		owner.move_dir = pick(valid_directions)