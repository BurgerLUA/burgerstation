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

	var/area/initial_area = get_area(owner)

	if(get_dist(N,start_turf) > roaming_distance || N.loc != initial_area || locate(/mob/) in N.contents)
		valid_directions -= NORTH

	if(get_dist(E,start_turf) > roaming_distance || E.loc != initial_area || locate(/mob/) in E.contents)
		valid_directions -= EAST

	if(get_dist(S,start_turf) > roaming_distance || S.loc != initial_area || locate(/mob/) in S.contents)
		valid_directions -= SOUTH

	if(get_dist(W,start_turf) > roaming_distance || W.loc != initial_area || locate(/mob/) in W.contents)
		valid_directions -= WEST

	if(length(valid_directions))
		owner.move_dir = pick(valid_directions)