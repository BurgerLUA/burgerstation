#define ALERT_LEVEL_NONE 0 //No threats detected.
#define ALERT_LEVEL_NOISE 1 //We heard or saw something strange that requires further investigation. Probably not a hostile, though.
#define ALERT_LEVEL_CAUTION 2 //We heard or saw something strange that is more than likely a hostile.
#define ALERT_LEVEL_ALERT 3 //We are currently engaged with hostiles.

/ai/

	var/mob/living/owner

	var/atom/objective_move
	var/mob/living/objective_attack
	var/mob/living/objective_defend

	var/radius_find_enemy = VIEW_RANGE

	var/objective_ticks = 0
	var/attack_ticks = 0
	var/movement_ticks = 0

	//Measured in ticks. 0 means synced to life. 1 means a delay of 1 tick in between
	var/objective_delay = 3
	var/attack_delay = 0
	var/movement_delay = 0

	var/list/target_distribution_x = list(0,16,16,16,32)
	var/list/target_distribution_y = list(16,16,16,8,8,32,32)

	var/turf/start_turf

	var/only_attack_players = FALSE

	var/sync_movement_delay = TRUE
	var/sync_attack_delay = FALSE

	var/stationary = TRUE

	var/roaming_distance = 5

	var/attack_distance_min = 0
	var/attack_distance_max = 1

	var/enabled = FALSE

	var/left_click_chance = 90

	var/timeout_threshold = 600 //Amount of deciseconds of inactivty is required to ignore players. Set to 0 to disable.

	var/frustration = 0
	var/frustration_threshold = 10 //Above this means they'll try to find a new target.

	var/list/attackers = list()

	var/kick_chance = 10

	var/attack_on_block = FALSE

	var/path_steps = 1
	var/list/Vector2D/current_path = list()

	var/distance_target_min = 1
	var/distance_target_max = 1

	var/true_sight = FALSE //Set to true if it can see invisible enemies.
	var/use_vision = FALSE //Set to true if it can only see things in a cone. Set to false if it can see in a 360 degree view. Note that this is affected by alert level.
	var/alert_level = ALERT_LEVEL_NONE //Alert level system

/ai/Destroy()
	if(owner)
		owner.ai = null
	owner = null
	objective_move = null
	objective_attack = null
	objective_defend = null
	start_turf = null
	all_living_ai -= src
	attackers.Cut()
	return ..()

/ai/New(var/mob/living/desired_owner)

	owner = desired_owner

	if(sync_attack_delay)
		attack_delay = CEILING(desired_owner.get_attack_delay()/LIFE_TICK,1)

	if(sync_movement_delay)
		movement_delay = CEILING(TICKS_TO_DECISECONDS(owner.get_movement_delay())/LIFE_TICK,1)

	attack_ticks = rand(0,attack_delay)
	movement_ticks = rand(0,movement_delay)
	objective_ticks = rand(0,objective_delay)

	start_turf = get_turf(owner)

	all_living_ai += src

/ai/proc/set_path(var/list/Vector2D/desired_path = list())
	enabled = TRUE
	path_steps = 1
	current_path = desired_path
	frustration = 0
	owner.move_dir = 0
	start_turf = get_turf(owner)
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
		objective_ticks = 0
		handle_objectives()

	movement_ticks += 1
	if(movement_ticks >= movement_delay)
		movement_ticks = 0
		handle_movement()

	if(owner)
		owner.handle_movement(DECISECONDS_TO_TICKS(AI_TICK))

	attack_ticks += 1
	if(attack_ticks >= attack_delay)
		attack_ticks = 0
		handle_attacking()


	return TRUE

/ai/proc/attack_message()
	return TRUE

/ai/proc/can_attack(var/atom/target,var/left_click=FALSE)
	return TRUE

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

	attack_ticks = 0

/ai/proc/handle_movement()

	owner.movement_flags = 0x0

	if(objective_attack)

		owner.movement_flags = MOVEMENT_RUNNING

		var/target_distance = get_dist(owner,objective_attack)

		if(target_distance < attack_distance_min)
			owner.move_dir = get_dir(objective_attack,owner)
		if(target_distance > attack_distance_max)
			owner.move_dir = get_dir(owner,objective_attack)
		else
			owner.move_dir = pick(list(0,0,0,0,turn(get_dir(owner,objective_attack),90),turn(get_dir(owner,objective_attack),-90)))

	else if(current_path && length(current_path))

		owner.movement_flags = MOVEMENT_NORMAL

		if(frustration > frustration_threshold)
			path_steps--
			if(path_steps < 1)
				path_steps = 3

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

	else if(roaming_distance && get_dist(owner,start_turf) >= roaming_distance)
		owner.movement_flags = MOVEMENT_WALKING
		owner.move_dir = get_dir(owner,start_turf)
	else if(alert_level == ALERT_LEVEL_CAUTION)
		owner.movement_flags = MOVEMENT_WALKING
		owner.move_dir = pick(list(0,0,0,0,NORTH,EAST,SOUTH,WEST))
	else
		owner.movement_flags = MOVEMENT_NORMAL
		owner.move_dir = 0


/ai/proc/hostile_message()
	return FALSE

/ai/proc/set_objective(var/mob/living/L)

	if(objective_attack && attackers[objective_attack])
		attackers -= objective_attack

	objective_attack = L

	if(L)
		set_alert_level(ALERT_LEVEL_ALERT)
		owner.set_dir(get_dir(owner,L))
	else
		set_alert_level(ALERT_LEVEL_CAUTION,TRUE)

	return TRUE

/ai/proc/handle_objectives()

	var/list/possible_targets = get_possible_targets()

	if(objective_attack)
		if(!possible_targets[objective_attack] || !should_attack_mob(objective_attack))
			set_objective(null)
			frustration = 0
		if(get_dist(owner,objective_attack) > attack_distance_max + 1)
			frustration ++
	else
		frustration = 0

	if(!objective_attack || frustration > frustration_threshold)

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

	objective_ticks = 0

/ai/proc/get_attack_score(var/mob/living/L)
	return -get_dist(L.loc,owner.loc)

/ai/proc/should_attack_mob(var/mob/living/L)

	if(L.dead)
		return FALSE

	var/area/A = get_area(L)
	var/area/starting_area = get_area(start_turf)

	if(A && A.flags_area & FLAGS_AREA_NO_DAMAGE && !starting_area.flags_area & FLAGS_AREA_NO_DAMAGE)
		return FALSE

/*
	if(!true_sight && L.is_sneaking)
		return FALSE
*/

	if(timeout_threshold && L.client && L.client.inactivity >= timeout_threshold)
		return FALSE

	if(only_attack_players)
		return exists(L.client)
	else
		return L.iff_tag != owner.iff_tag

	return FALSE

/ai/proc/get_possible_targets()

	. = attackers.Copy()

	if(radius_find_enemy <= 0)
		return .

	for(var/mob/living/advanced/player/P in view(radius_find_enemy,owner))
		if(alert_level != ALERT_LEVEL_ALERT && !owner.is_facing(P))
			continue
		if(!should_attack_mob(P))
			continue

		.[P] = TRUE

	return .

/ai/proc/on_damage_received(var/atom/atom_damaged,var/atom/attacker,var/list/damage_table,var/damage_amount)

	if(!attackers[attacker])
		attackers[attacker] = TRUE

	set_alert_level(ALERT_LEVEL_ALERT)

	return TRUE

/ai/proc/Bump(var/atom/obstacle)

	if(is_player(obstacle))
		set_alert_level(ALERT_LEVEL_CAUTION)

	if(attack_on_block && !do_attack(obstacle,prob(left_click_chance)))
		frustration++

	return FALSE

/ai/proc/set_alert_level(var/desired_alert_level,var/can_lower=FALSE)

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

	if(owner.stored_alert_effect)
		qdel(owner.stored_alert_effect)
		owner.stored_alert_effect = null

	if(new_alert_level == ALERT_LEVEL_ALERT)
		owner.stored_alert_effect = new /obj/effect/temp/alert/exclaim(owner.loc)

	else if(new_alert_level == ALERT_LEVEL_CAUTION)
		owner.stored_alert_effect = new /obj/effect/temp/alert/question(owner.loc)

	else if(new_alert_level == ALERT_LEVEL_NOISE)
		owner.stored_alert_effect = new /obj/effect/temp/alert/huh(owner.loc)

	owner.move_dir = 0
	movement_ticks = movement_delay - DECISECONDS_TO_TICKS(1)

	return TRUE