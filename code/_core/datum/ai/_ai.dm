/ai/
	name = "Default AI"
	desc = "The AI."

	var/mob/living/owner

	var/atom/objective_move
	var/mob/living/objective_attack
	var/mob/living/objective_defend

	var/radius_find_enemy = 8

	var/objective_ticks = 0
	var/attack_ticks = 0
	var/movement_ticks = 0

	//Measured in ticks. 0 means synced to life. 1 means a delay of 1 tick in between
	var/objective_delay = 3
	var/attack_delay = 0
	var/movement_delay = 0

	var/list/target_distribution = list(16,16,16,8,8,32,32)

	var/turf/start_turf

	var/simple = TRUE

	var/sync_stats = TRUE

	var/stationary = TRUE

	var/true_sight = FALSE

	var/roaming_distance = 5

	var/attack_distance = 1

/ai/New(var/mob/living/desired_owner)

	owner = desired_owner

	if(sync_stats)
		attack_delay = ceiling(owner.get_attack_delay()/LIFE_TICK)
		movement_delay = ceiling(TICKS_TO_DECISECONDS(owner.get_movement_delay())/LIFE_TICK)

	attack_ticks = rand(0,attack_delay)
	movement_ticks = rand(0,movement_delay)
	objective_ticks = rand(0,objective_delay)

	start_turf = get_turf(owner)

/ai/proc/on_life()

	if(!is_turf(owner.loc))
		return TRUE

	objective_ticks += 1
	if(objective_ticks >= objective_delay)
		handle_objectives()

	movement_ticks += 1
	if(movement_ticks >= movement_delay)
		handle_movement()

	attack_ticks += 1
	if(attack_ticks >= attack_delay)
		handle_attacking()

	return TRUE

/ai/proc/handle_attacking()

	if(objective_attack && get_dist(owner,objective_attack) <= attack_distance)
		owner.move_dir = 0
		var/list/params = list(
			"icon-x" = num2text(16),
			"icon-y" = num2text(pick(target_distribution)),
			"left" = 0,
			"right" = 0,
			"middle" = 0,
			"ctrl" = 0,
			"shift" = 0,
			"alt" = 0
		)

		if(prob(90))
			params["left"] = TRUE
			owner.on_left_down(objective_attack,owner,null,params)
		else
			params["right"] = TRUE
			owner.on_right_down(objective_attack,owner,null,params)

	attack_ticks = 0

/ai/proc/handle_movement()

	if(objective_attack)
		if(get_dist(owner,objective_attack) > attack_distance)
			owner.move_dir = get_dir(owner,objective_attack)
		else
			owner.move_dir = 0

	else if(get_dist(owner,start_turf) >= roaming_distance)
		owner.move_dir = get_dir(owner,start_turf)
	else if(stationary)
		owner.move_dir = 0
	else
		owner.move_dir = pick(list(0,0,0,0,NORTH,EAST,SOUTH,WEST))

	movement_ticks = 0

/ai/proc/hostile_message()
	return FALSE

/ai/proc/handle_objectives()

	if(objective_attack && !can_see_enemy(objective_attack))
		objective_attack = null

	if(!objective_attack)
		var/list/possible_targets = get_possible_targets()

		var/atom/best_target
		var/best_score = 0

		for(var/mob/living/L in possible_targets)
			if(!true_sight && L.is_sneaking)
				continue

			var/local_score = get_attack_score(L)
			if(!best_score || local_score > best_score)
				best_target = L
				best_score = local_score

		if(best_target)
			objective_attack = best_target
			hostile_message()

	objective_ticks = 0

/ai/proc/get_attack_score(var/mob/living/L)
	return -get_dist(L.loc,owner.loc)

/ai/proc/should_attack_mob(var/mob/living/L)

	if(L.status & FLAG_STATUS_DEAD)
		return FALSE

	var/area/A = get_area(L)
	var/area/starting_area = get_area(start_turf)
	if(A && A.safe && !starting_area.safe)
		return FALSE

	if(simple)
		return L.client

	for(var/id in owner.factions)
		var/faction/F = owner.factions[id]
		if(F.is_hostile_to_mob(L))
			return TRUE

	return FALSE

/ai/proc/can_see_enemy(var/mob/living/L)
	var/list/possible_targets = get_possible_targets()
	return (L in possible_targets)

/ai/proc/get_possible_targets()
	var/list/possible_targets = list()
	for(var/mob/living/advanced/player/P in view(radius_find_enemy,owner))
		if(should_attack_mob(P))
			possible_targets += P

	return possible_targets

/ai/simple/
	name = "Simple AI"
	simple = TRUE

/ai/simple/handle_attacking()

	if(objective_attack && get_dist(owner,objective_attack) <= attack_distance)
		owner.move_dir = 0
		owner.attack(owner,objective_attack)

	attack_ticks = 0







