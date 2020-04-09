#define ALERT_LEVEL_NONE 0 //No threats detected.
#define ALERT_LEVEL_NOISE 1 //We heard or saw something strange that requires further investigation. Probably not a hostile, though.
#define ALERT_LEVEL_CAUTION 2 //We heard or saw something strange that is more than likely a hostile.
#define ALERT_LEVEL_ALERT 3 //We are currently engaged with hostiles.

/ai/

	var/mob/living/owner

	var/atom/objective_move
	var/mob/living/objective_attack

	var/radius_find_enemy = VIEW_RANGE

	var/objective_ticks = 0
	var/attack_ticks = 0

	//Measured in ticks. 0 means synced to life. 1 means a delay of 1 tick in between
	var/objective_delay = 3
	var/attack_delay = 0

	var/list/target_distribution_x = list(0,16,16,16,32)
	var/list/target_distribution_y = list(16,16,16,8,8,32,32)

	var/turf/start_turf

	var/only_attack_players = FALSE

	var/stationary = TRUE

	var/roaming_distance = 5

	var/attack_distance_min = 0
	var/attack_distance_max = 1

	var/enabled = FALSE

	var/left_click_chance = 90

	var/timeout_threshold = 600 //Amount of deciseconds of inactivty is required to ignore players. Set to 0 to disable.

	var/frustration_attack = 0
	var/frustration_move = 0
	var/frustration_path = 0

	var/turf/path_start_turf
	var/turf/path_end_turf


	var/frustration_threshold = 10 //Above this means they'll try to find a new target.

	var/list/attackers = list()

	var/kick_chance = 10

	var/attack_on_block = FALSE

	var/path_steps = 1
	var/list/Vector2D/current_path = list()

	var/distance_target_min = 1
	var/distance_target_max = 1

	var/use_alerts = TRUE
	var/true_sight = FALSE //Set to true if it can see invisible enemies.
	var/use_cone_vision = TRUE //Set to true if it can only see things in a cone. Set to false if it can see in a 360 degree view. Note that this only applies to when the NPC is not in alert.
	var/alert_level = ALERT_LEVEL_NONE //Alert level system
	var/alert_time = 600 //Deciseconds
	var/sidestep_next = FALSE

	var/ignore_immortal = FALSE

	var/retaliate = TRUE

/ai/Destroy()
	if(owner)
		owner.ai = null
	owner = null
	objective_move = null
	objective_attack = null
	start_turf = null
	all_living_ai -= src
	attackers.Cut()
	path_start_turf = null
	path_end_turf = null
	return ..()

/ai/New(var/mob/living/desired_owner)

	owner = desired_owner

	attack_ticks = rand(0,attack_delay)
	objective_ticks = rand(0,objective_delay)

	start_turf = get_turf(owner)

	all_living_ai += src

/ai/proc/set_path(var/list/Vector2D/desired_path = list())

	if(!desired_path || !length(desired_path))
		current_path = null
		path_start_turf = null
		path_end_turf = null
		path_steps = null
		frustration_path = 0
		return TRUE

	enabled = TRUE
	path_steps = 1
	current_path = desired_path
	frustration_path = 0
	frustration_move = 0
	owner.move_dir = 0
	path_start_turf = get_turf(owner)
	var/Vector2D/last_path = desired_path[length(desired_path)]
	path_end_turf = locate(last_path.x,last_path.y,1)
	return TRUE

/ai/proc/on_life()

	if(!enabled)
		return FALSE

	if(!owner)
		qdel(src)
		return FALSE

	if(!owner.initialized)
		return FALSE

	if(owner.dead)
		return FALSE

	if(!isturf(owner.loc))
		return FALSE

	objective_ticks += 1
	if(objective_ticks >= objective_delay)
		handle_objectives()
		objective_ticks = 0

	attack_ticks += 1
	if(attack_ticks >= attack_delay)
		handle_attacking()
		attack_ticks = 0

	if(alert_level && alert_level <= ALERT_LEVEL_CAUTION)
		alert_time -= LIFE_TICK
		if(alert_time <= 0)
			alert_time = initial(alert_time)
			alert_level -= 1

	owner.handle_movement(DECISECONDS_TO_TICKS(AI_TICK))

	return TRUE

/ai/proc/attack_message()
	return TRUE

/ai/proc/can_attack(var/atom/target,var/left_click=FALSE)
	return target.can_be_attacked(owner)

/ai/proc/do_attack(var/atom/target,var/left_click=FALSE)

	owner.move_dir = 0

	var/list/params = list(
		PARAM_ICON_X = num2text(pick(target_distribution_x)),
		PARAM_ICON_Y = num2text(pick(target_distribution_y)),
		"left" = 0,
		"right" = 0,
		"middle" = 0,
		"ctrl" = 0,
		"shift" = 0,
		"alt" = 0
	)

	if(left_click)
		params["left"] = TRUE
		owner.on_left_down(target,null,null,params)
	else
		params["right"] = TRUE
		owner.on_right_down(target,null,null,params)

	return TRUE

/ai/proc/handle_attacking()
	if(objective_attack && get_dist(owner,objective_attack) <= distance_target_max)
		var/is_left_click = prob(left_click_chance)
		if(can_attack(objective_attack,is_left_click))
			do_attack(objective_attack,is_left_click)
	return TRUE

/ai/proc/set_move_objective(var/atom/desired_objective)
	objective_move = desired_objective
	return TRUE

/ai/proc/handle_movement_attack_objective()
	if(objective_attack)
		owner.movement_flags = MOVEMENT_RUNNING
		var/target_distance = get_dist(owner,objective_attack)
		if(target_distance < attack_distance_min)
			owner.move_dir = get_dir(objective_attack,owner)
		if(target_distance > attack_distance_max)
			owner.move_dir = get_dir(owner,objective_attack)
		else if(prob(target_distance <= 1 ? 25 : 5))
			owner.move_dir = pick(turn(get_dir(owner,objective_attack),90),turn(get_dir(owner,objective_attack),-90))
		return TRUE
	return FALSE

/ai/proc/handle_movement_move_objective()
	if(objective_move)
		if(get_dist(owner,objective_move) > 1)
			owner.movement_flags = MOVEMENT_NORMAL
			owner.move_dir = get_dir(owner,objective_move)
		else
			set_move_objective(null)
			owner.movement_flags = MOVEMENT_NORMAL
			owner.move_dir = 0x0
		return TRUE
	return FALSE

/ai/proc/handle_movement_path()
	if(current_path && length(current_path))
		owner.movement_flags = MOVEMENT_NORMAL
		if(path_steps <= length(current_path))
			var/Vector2D/desired_node = current_path[path_steps]
			if(desired_node.x == owner.x && desired_node.y == owner.y)
				path_steps++
				owner.move_dir = 0
			else
				owner.move_dir = get_dir(owner,locate(desired_node.x,desired_node.y,1))
		else
			set_path(null)
			owner.move_dir = 0
		return TRUE
	return FALSE

/ai/proc/handle_movement_path_frustration()

	if(frustration_path > frustration_threshold)

		frustration_path = 0

		var/obj/marker/map_node/N_start = find_closest_node(owner)
		if(!N_start)
			set_path(null)
			return FALSE

		var/obj/marker/map_node/N_end = find_closest_node(path_end_turf)
		if(!N_end)
			set_path(null)
			return FALSE

		var/obj/marker/map_node/list/found_path = N_start.find_path(N_end)
		if(!found_path)
			set_path(null)
			return FALSE

		set_path(found_path)

		return TRUE

	return FALSE

/ai/proc/handle_movement_roaming()
	if(roaming_distance && get_dist(owner,start_turf) >= roaming_distance)
		owner.movement_flags = MOVEMENT_WALKING
		owner.move_dir = get_dir(owner,start_turf)
		return TRUE
	return FALSE

/ai/proc/handle_movement_alert()
	if(alert_level == ALERT_LEVEL_CAUTION)
		owner.movement_flags = MOVEMENT_WALKING
		owner.move_dir = pick(list(0,0,0,0,NORTH,EAST,SOUTH,WEST))
		return TRUE
	return FALSE

/ai/proc/handle_movement_sidestep()

	if(sidestep_next)
		if(!owner.move_dir)
			owner.move_dir = pick(DIRECTIONS_INTERCARDINAL)
		var/move_cone = pick(45,90)
		owner.move_dir = turn(owner.dir,pick(-move_cone,move_cone))
		sidestep_next = FALSE
		if(path_end_turf)
			frustration_path++
		return TRUE

	return FALSE

/ai/proc/handle_movement_crowding()

	var/living_count = 0
	var/turf/T = get_turf(owner)
	for(var/mob/living/L in T.contents)
		living_count++
		if(living_count >= 2)
			sidestep_next = TRUE
			return TRUE

	return FALSE


/ai/proc/handle_movement()

	owner.movement_flags = MOVEMENT_NORMAL

	if(handle_movement_sidestep())
		return TRUE

	if(handle_movement_crowding())
		return TRUE

	if(handle_movement_path_frustration())
		return TRUE

	if(handle_movement_attack_objective())
		return TRUE

	if(handle_movement_move_objective())
		return TRUE

	if(handle_movement_alert())
		return TRUE

	if(handle_movement_path())
		return TRUE

	if(handle_movement_roaming())
		return TRUE

	return FALSE


/ai/proc/hostile_message()
	return FALSE

/ai/proc/set_objective(var/mob/living/L)

	if(L == owner)
		return FALSE

	var/atom/old_attack = objective_attack

	if(objective_attack && attackers[objective_attack])
		attackers -= objective_attack

	objective_attack = L
	frustration_attack = 0

	owner.set_intent(objective_attack || owner.stand ? INTENT_HARM : INTENT_HELP)

	if(L)
		set_alert_level(ALERT_LEVEL_ALERT)
		owner.set_dir(get_dir(owner,L))
	else if(old_attack && !old_attack.qdeleting)
		set_alert_level(ALERT_LEVEL_CAUTION,TRUE)
		set_move_objective(old_attack)
	else
		set_alert_level(ALERT_LEVEL_NOISE,TRUE)

	return TRUE

/ai/proc/handle_objectives()

	var/list/possible_targets = get_possible_targets()

	if(objective_attack)
		if(!possible_targets[objective_attack] || !should_attack_mob(objective_attack))
			set_objective(null)
		if(get_dist(owner,objective_attack) > attack_distance_max + 1)
			frustration_attack++

	if(!objective_attack || frustration_attack > frustration_threshold)

		var/atom/best_target
		var/best_score = 0

		for(var/mob/living/L in possible_targets)
			var/local_score = get_attack_score(L)
			if(!best_score || local_score > best_score)
				best_target = L
				best_score = local_score

		if(best_target && best_target != objective_attack)
			hostile_message()
			set_objective(best_target)

		frustration_attack = 0

	return TRUE

/ai/proc/get_attack_score(var/mob/living/L)
	return -get_dist(L.loc,owner.loc)

/ai/proc/should_attack_mob(var/mob/living/L)

	if(L == owner)
		return FALSE

	if(L.dead)
		return FALSE

	if(!can_attack(L))
		return FALSE

	if(L.immortal && !ignore_immortal)
		return FALSE

	if(timeout_threshold && L.client && L.client.inactivity >= timeout_threshold)
		return FALSE

	if(only_attack_players)
		return exists(L.client)
	else
		return !owner.iff_tag || L.iff_tag != owner.iff_tag

	return FALSE

/ai/proc/get_possible_targets()

	if(retaliate)
		. = attackers.Copy()
	else
		. = list()

	if(radius_find_enemy <= 0)
		return .

	if(only_attack_players)
		for(var/mob/living/advanced/player/P in view(radius_find_enemy,owner))
			if(use_cone_vision && alert_level != ALERT_LEVEL_ALERT && !owner.is_facing(P))
				continue
			if(!should_attack_mob(P))
				continue
			.[P] = TRUE
	else
		for(var/mob/living/L in view(radius_find_enemy,owner))
			if(!L.initialized)
				continue
			if(use_cone_vision && alert_level != ALERT_LEVEL_ALERT && !owner.is_facing(L))
				continue
			if(!should_attack_mob(L))
				continue
			.[L] = TRUE

	return .

/ai/proc/on_damage_received(var/atom/atom_damaged,var/atom/attacker,var/list/damage_table,var/damage_amount)

	if(!attackers[attacker])
		attackers[attacker] = TRUE

	set_alert_level(ALERT_LEVEL_ALERT)

	return TRUE

/ai/proc/on_move(var/success,var/atom/NewLoc,Dir=0)

	if(!success)
		frustration_move++
		sidestep_next = TRUE
		if(current_path)
			frustration_path++

	return TRUE

/ai/proc/Bump(var/atom/obstacle)

	if(is_player(obstacle))
		set_alert_level(ALERT_LEVEL_CAUTION)

	if(attack_on_block)
		do_attack(obstacle,prob(left_click_chance))

	return TRUE

/ai/proc/set_alert_level(var/desired_alert_level,var/can_lower=FALSE)

	if(!use_alerts)
		return FALSE

	var/old_alert_level = alert_level

	if(can_lower)
		alert_level = desired_alert_level
	else
		alert_level = max(desired_alert_level,alert_level)

	if(old_alert_level != alert_level)
		on_alert_level_changed(old_alert_level,alert_level)
		return TRUE

	return FALSE

/ai/proc/on_alert_level_changed(var/old_alert_level,var/new_alert_level)

	enabled = TRUE

	if(owner.stored_alert_effect)
		qdel(owner.stored_alert_effect)
		owner.stored_alert_effect = null

	if(new_alert_level == ALERT_LEVEL_ALERT)
		owner.stored_alert_effect = new /obj/effect/alert/exclaim(owner)

	else if(new_alert_level == ALERT_LEVEL_CAUTION)
		owner.stored_alert_effect = new /obj/effect/alert/question(owner)

	else if(new_alert_level == ALERT_LEVEL_NOISE)
		owner.stored_alert_effect = new /obj/effect/alert/huh(owner)

	owner.move_dir = 0

	return TRUE