/ai/

	var/mob/living/owner

	var/atom/objective_move
	var/should_follow_objective_move = FALSE

	var/mob/living/objective_attack
	var/atom/objective_investigate

	var/radius_find_enemy = AI_DETECTION_RANGE //No alert.
	var/radius_find_enemy_noise = AI_DETECTION_RANGE_NOISE
	var/radius_find_enemy_caution = AI_DETECTION_RANGE_CAUTION
	var/radius_find_enemy_combat = AI_DETECTION_RANGE_COMBAT

	//Measured in ticks.
	var/objective_ticks = 0

	//Measured in ticks.
	var/objective_delay = DECISECONDS_TO_TICKS(10)

	var/list/target_distribution_x = list(8,16,16,16,24)
	var/list/target_distribution_y = list(8,16,16,16,24)

	var/turf/start_turf

	var/roaming_distance = 5

	var/attack_distance_min = 0
	var/attack_distance_max = 1

	var/left_click_chance = 90

	var/timeout_threshold = 600 //Amount of deciseconds of inactivty is required to ignore players. Set to 0 to disable.

	var/frustration_attack = 0
	var/frustration_attack_threshold = 4 //Above this means they'll try to find a new target.

	var/frustration_move = 0
	var/frustration_move_threshold = 4 //Above this means they'll try to alter their movement.

	var/frustration_path = 0
	var/frustration_path_threshold = 10 //Above this means they'll try to find a new path.

	var/turf/path_start_turf
	var/turf/path_end_turf



	var/list/attackers = list()

	var/kick_chance = 10

	var/attack_on_block = FALSE

	var/path_steps = 1
	var/list/Vector3D/current_path = list()

	var/distance_target_min = 1
	var/distance_target_max = 1

	var/use_alerts = TRUE
	var/true_sight = FALSE //Set to true if it can see invisible enemies.
	var/use_cone_vision = TRUE //Set to true if it can only see things in a cone. Set to false if it can see in a 360 degree view. Note that this only applies to when the NPC is not in alert.
	var/alert_level = ALERT_LEVEL_NONE //Alert level system
	var/alert_time = 600 //Deciseconds
	var/sidestep_next = FALSE
	var/should_investigate_alert = TRUE

	var/grab_time = 0
	var/grab_time_max = 20 //How long, in deciseconds, should we allow someone to grab us?

	var/ignore_immortal = FALSE

	var/list/enemy_tags = list()

	var/reaction_time = 4 //In Deciseconds.

	var/stored_sneak_power = 0

	var/resist_grabs = TRUE

	var/retaliate = TRUE //Should we attack when getting hit?
	var/aggression = 2 //Thanks elder scrolls.
	//0 = Does not search for enemies; only attacks when told to (example: getting hit by damage, when retaliate is true).
	//1 = Attacks enemies in enemy tags.
	//2 = Attacks people who don't have the same loyalty tag as them.
	//3 = Attacks literally everyone in sight.
	var/assistance = 1
	//0 = Helps no one but themselves.
	//1 = Helps people with the same loyalty tag as them.

	//Roaming Stuff. Mostly read only.
	var/roam = FALSE
	var/roam_counter = 10

	var/debug = FALSE

	var/active = FALSE

	var/delete_on_no_path = FALSE

	var/idle_time = 0

/ai/proc/set_active(var/desired_active=TRUE,var/force=FALSE)

	if(!force && active == desired_active)
		return FALSE

	active = desired_active

	if(active)
		SSai.active_ai |= src
		SSai.inactive_ai -= src
	else
		SSai.active_ai -= src
		SSai.inactive_ai |= src

		set_objective(null)
		set_move_objective(null)
		CALLBACK_REMOVE("set_new_objective_\ref[src]")
		attackers.Cut()

	return TRUE

/ai/proc/on_death()
	set_active(FALSE)
	set_path(null)
	return TRUE

/ai/Destroy()
	if(owner)
		owner.ai = null
	owner = null
	objective_move = null
	objective_attack = null
	start_turf = null
	attackers.Cut()
	path_start_turf = null
	path_end_turf = null

	SSai.active_ai -= src
	SSai.inactive_ai -= src

	SSbossai.active_ai -= src
	SSbossai.inactive_ai -= src

	return ..()

/ai/New(var/mob/living/desired_owner)

	owner = desired_owner

	objective_ticks = rand(0,objective_delay)

	start_turf = get_turf(owner)

	return ..()

/ai/proc/set_path(var/list/Vector3D/desired_path = list())

	if(!desired_path || !length(desired_path))
		current_path = null
		path_start_turf = null
		path_end_turf = null
		path_steps = null
		frustration_path = 0
		return TRUE

	set_active(TRUE)

	path_steps = 1
	current_path = desired_path
	frustration_path = 0
	frustration_move = 0
	owner.move_dir = 0
	path_start_turf = get_turf(owner)
	var/Vector3D/last_path = desired_path[length(desired_path)]
	path_end_turf = locate(last_path.x,last_path.y,last_path.z)
	return TRUE


/ai/PostInitialize()
	. = ..()
	set_active(active,TRUE)
	return .

/ai/proc/should_life()

	if(!active)
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

	if(owner.has_status_effects(STUN,SLEEP,PARALYZE))
		return FALSE

	if(resist_grabs && owner.grabbing_hand && is_enemy(owner.grabbing_hand.owner) && owner.next_resist <= world.time)
		owner.resist()
		return FALSE

	return TRUE

/ai/proc/get_objective_delay()

	. = objective_delay

	if(objective_attack)
		. *= 4

	return .


/ai/proc/on_life(var/tick_rate=AI_TICK)

	objective_ticks += tick_rate
	if(objective_ticks >= get_objective_delay())
		objective_ticks = 0
		handle_objectives()
		if(length(current_path) || objective_attack || alert_level >= ALERT_LEVEL_NOISE)
			idle_time = 0
		else
			idle_time += tick_rate
			if(idle_time >= 600) //Idle for more than a minute means you're just wasting space.
				set_active(FALSE)
				return FALSE

	if(owner.attack_next <= world.time)
		handle_attacking()

	if(alert_level >= ALERT_LEVEL_NOISE && alert_level <= ALERT_LEVEL_CAUTION)
		alert_time -= tick_rate
		if(alert_time <= 0)
			alert_time = initial(alert_time)
			set_alert_level(max(0,alert_level-1),TRUE)

	if(owner.move_delay <= 0)
		handle_movement_reset()
		handle_movement()

	owner.handle_movement(tick_rate)

	return TRUE

/ai/proc/attack_message()
	return TRUE

/ai/proc/can_owner_attack(var/atom/target,var/left_click=FALSE)
	return target.can_be_attacked(owner)

/ai/proc/do_attack(var/atom/target,var/left_click=FALSE)

	if(!owner || !target)
		return FALSE

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
	if(objective_attack && get_dist(owner,objective_attack) <= distance_target_max && objective_attack.can_be_attacked())
		var/is_left_click = prob(left_click_chance)
		spawn do_attack(objective_attack,is_left_click)
		return TRUE
	return FALSE

/ai/proc/set_move_objective(var/atom/desired_objective,var/follow = FALSE) //Set follow to true if it should constantly follow the person.
	if(desired_objective) set_active(TRUE)
	objective_move = desired_objective
	should_follow_objective_move = follow
	return TRUE

/ai/proc/handle_movement_attack_objective()

	if(objective_attack)
		var/target_distance = get_dist(owner,objective_attack)
		if(target_distance < attack_distance_min)
			owner.move_dir = get_dir(objective_attack,owner)
			owner.movement_flags = MOVEMENT_RUNNING
		if(target_distance > attack_distance_max)
			owner.move_dir = get_dir(owner,objective_attack)
			owner.movement_flags = MOVEMENT_RUNNING
		else
			owner.movement_flags = MOVEMENT_NORMAL
			if(prob(target_distance <= 1 ? 25 : 5))
				owner.move_dir = pick(turn(get_dir(owner,objective_attack),90),turn(get_dir(owner,objective_attack),-90))
		return TRUE

	return FALSE

/ai/proc/handle_movement_move_objective()
	if(objective_move)
		var/move_distance = get_dist(owner,objective_move)
		if(move_distance > 1)
			if(should_follow_objective_move && move_distance >= 4)
				owner.movement_flags = MOVEMENT_RUNNING
			else
				owner.movement_flags = MOVEMENT_NORMAL
			owner.move_dir = get_dir(owner,objective_move)
		else
			if(!should_follow_objective_move)
				set_move_objective(null)
			owner.movement_flags = MOVEMENT_NORMAL
			owner.move_dir = 0x0
		return TRUE
	return FALSE

/ai/proc/handle_movement_path()
	if(current_path && length(current_path))
		owner.movement_flags = MOVEMENT_NORMAL
		if(path_steps <= length(current_path))
			var/Vector3D/desired_node = current_path[path_steps]
			var/turf/T = get_turf(owner)
			if(desired_node.x == T.x && desired_node.y == T.y)
				path_steps++
				owner.move_dir = 0
				frustration_path = 0
			else
				owner.move_dir = get_dir(owner,locate(desired_node.x,desired_node.y,desired_node.z))
				if(length(SSai.stuck_turfs))
					var/turf/turf_to_check = get_step(owner,owner.move_dir)
					var/turf/we_fucked_anyways = get_turf(owner)
					if(SSai.stuck_turfs[turf_to_check] && !SSai.stuck_turfs[we_fucked_anyways])
						owner.move_dir = turn(owner.move_dir,180)
					if(owner.old_turf && owner.old_turf == get_step(owner,owner.move_dir))
						SSai.stuck_turfs[owner.old_turf] = TRUE
		else
			start_turf = get_turf(owner)
			set_path(null)
			owner.move_dir = 0
		return TRUE
	return FALSE

/ai/proc/handle_movement_path_frustration()

	if(frustration_path > frustration_path_threshold)

		frustration_path = 0

		var/turf/bad_turf = get_turf(owner)

		if(bad_turf)
			SSai.stuck_turfs[bad_turf] = TRUE

		var/obj/marker/map_node/N_start = find_closest_node(owner)
		if(!N_start)
			log_error("[owner] ([owner.x],[owner.y],[owner.z]) is stuck and cannot find a path start!")
			set_path(null)
			if(delete_on_no_path)
				queue_delete(owner,0,TRUE)
			return FALSE

		var/obj/marker/map_node/N_end = find_closest_node(path_end_turf)
		if(!N_end)
			log_error("[owner] ([owner.x],[owner.y],[owner.z]) is stuck and cannot find a path end!")
			set_path(null)
			if(delete_on_no_path)
				queue_delete(owner,0,TRUE)
			return FALSE

		var/obj/marker/map_node/list/found_path = N_start.find_path(N_end)
		if(!found_path)
			log_error("[owner] ([owner.x],[owner.y],[owner.z]) is stuck and cannot find a final path!")
			set_path(null)
			if(delete_on_no_path)
				queue_delete(owner,0,TRUE)
			return FALSE

		set_path(found_path)

		return TRUE

	return FALSE

/ai/proc/handle_movement_roaming()
	if(roaming_distance)
		if(get_dist(owner,start_turf) >= roaming_distance)
			owner.movement_flags = MOVEMENT_WALKING
			owner.move_dir = get_dir(owner,start_turf)
			return TRUE
		else
			if(roam)
				if(prob(5))
					owner.movement_flags = MOVEMENT_WALKING
					owner.move_dir = pick(DIRECTIONS_ALL)
					roam_counter -= 1
			else
				owner.movement_flags = MOVEMENT_WALKING
				owner.move_dir = 0x0
				if(prob(25))
					roam_counter -= 1
			if(roam_counter <= 0)
				roam = !roam
				roam_counter = initial(roam_counter)

	return FALSE

/ai/proc/handle_movement_alert()

	if(alert_level > ALERT_LEVEL_NONE && objective_investigate)
		owner.movement_flags = MOVEMENT_WALKING
		owner.move_dir = get_dir(owner,objective_investigate)
		return TRUE

	else if(alert_level == ALERT_LEVEL_CAUTION)
		owner.movement_flags = MOVEMENT_WALKING
		owner.move_dir = pick(list(0,0,0,0,NORTH,EAST,SOUTH,WEST))
		return TRUE

	return FALSE

/ai/proc/handle_movement_sidestep()

	if(sidestep_next)
		if(!owner.move_dir)
			owner.move_dir = pick(DIRECTIONS_INTERCARDINAL)

		if(prob(50))
			var/move_cone = pick(45,90)
			owner.move_dir = turn(owner.dir,pick(-move_cone,move_cone))
		else
			owner.move_dir = turn(owner.dir,180)
		sidestep_next = FALSE
		frustration_move = 0
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

/ai/proc/handle_movement_grabbed()

	if(owner.grabbing_hand)
		grab_time++
	else
		grab_time = 0

	if(owner.grabbing_hand && grab_time >= grab_time_max)
		var/turf/T = get_turf(owner.grabbing_hand)
		owner.move_dir = get_dir(T,owner)
		return TRUE

	return FALSE

/ai/proc/handle_movement_reset()
	owner.movement_flags = MOVEMENT_NORMAL
	owner.move_dir = 0x0
	return TRUE

/ai/proc/handle_movement()

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

/ai/proc/set_objective(var/atom/A)

	if(!owner || owner.qdeleting)
		return FALSE

	if(A == owner)
		return FALSE

	if(A && A.qdeleting)
		return FALSE

	var/atom/old_attack = objective_attack

	if(!A && old_attack && attackers[old_attack])
		attackers -= old_attack

	if(A) owner.set_dir(get_dir(owner,A))

	if(objective_investigate)
		objective_investigate = null

	if(is_living(A))
		if(!should_attack_mob(A))
			return FALSE
		frustration_attack = 0
		set_active(TRUE)
		set_alert_level(ALERT_LEVEL_COMBAT,A,A)
		objective_attack = A
		if(owner.boss && is_player(A))
			owner.add_player_to_boss(A)
		if(objective_move == objective_attack)
			objective_move = null
		owner.set_intent(objective_attack || owner.stand ? INTENT_HARM : INTENT_HELP)
		return TRUE

	frustration_attack = 0
	objective_attack = null
	owner.set_intent(owner.stand ? INTENT_HARM : INTENT_HELP)

	if(old_attack && !old_attack.qdeleting)
		if(is_living(old_attack))
			var/mob/living/L2 = old_attack
			if(L2.dead)
				set_alert_level(ALERT_LEVEL_NOISE,TRUE)
				return TRUE
		set_alert_level(ALERT_LEVEL_CAUTION,TRUE)
		set_move_objective(old_attack)
		return TRUE

	set_alert_level(ALERT_LEVEL_NONE,TRUE)

	return TRUE

/ai/proc/handle_objectives()

	if(CALLBACK_EXISTS("set_new_objective_\ref[src]"))
		return TRUE

	if(objective_attack)
		if(objective_attack.dead || objective_attack.qdeleting || (is_living(objective_attack) && !should_attack_mob(objective_attack)) || !can_see(objective_attack))
			set_objective(null)
		else if((get_dist(owner,objective_attack) > attack_distance_max + 1))
			frustration_attack++
		else
			frustration_attack = 0

	if(!objective_attack || frustration_attack > frustration_attack_threshold)
		var/list/possible_targets = get_possible_targets()
		var/atom/best_target
		var/best_score = 0
		for(var/k in possible_targets)
			var/mob/living/L = k
			var/local_score = get_attack_score(L)
			if(!best_score || local_score > best_score)
				best_target = L
				best_score = local_score
		if(best_target && best_target != objective_attack)
			CALLBACK("set_new_objective_\ref[src]",reaction_time,src,.proc/set_objective,best_target)

		frustration_attack = 0

	return TRUE

/ai/proc/get_attack_score(var/mob/living/L)

	var/dist = get_dist(L.loc,owner.loc)

	if(dist <= attack_distance_max)
		if(attackers[L])
			return 3000 - (L.health ? L.health.health_current : 0)
		if(L.ai && L.ai.objective_attack == owner)
			return 2000 - (L.health ? L.health.health_current : 0)
		return 1000 - (L.health ? L.health.health_current : 0)

	return -dist

/ai/proc/should_attack_mob(var/mob/living/L)

	if(L == owner)
		return FALSE

	if(L.dead)
		return FALSE

	if(L.immortal && !ignore_immortal)
		return FALSE

	if(timeout_threshold && L.client && L.client.inactivity >= timeout_threshold)
		return FALSE

	if(!is_enemy(L))
		return FALSE

	if(!L.can_be_attacked(owner))
		return FALSE

	if(is_advanced(L) && !L.client)
		var/mob/living/advanced/A = L
		if(A.handcuffed) //Don't target hostages.
			return FALSE

	return TRUE

/ai/proc/is_enemy(var/atom/A)

	if(istype(A,/mob/living/vehicle/))
		var/mob/living/vehicle/V = A
		if(!length(V.passengers))
			return FALSE
		A = V.passengers[1]

	if(A == owner)
		return FALSE

	if(is_living(A))
		var/mob/living/L = A
		if(L.ai && L.ai.objective_attack)
			if(L.ai.objective_attack == owner)
				return TRUE
			if(assistance == 1 && is_living(L.ai.objective_attack))
				var/mob/living/L2 = L.ai.objective_attack
				if(L2.loyalty_tag == owner.loyalty_tag)
					return TRUE

	switch(aggression)
		if(0)
			return FALSE
		if(1)
			if(!is_living(A))
				return FALSE
			var/mob/living/L = A
			return owner.loyalty_tag && L.loyalty_tag && (L.loyalty_tag in enemy_tags)
		if(2)
			if(!is_living(A))
				return TRUE
			var/mob/living/L = A
			return owner.loyalty_tag != L.loyalty_tag
		if(3)
			return TRUE

	return FALSE

/ai/proc/is_friend(var/mob/living/L)
	return owner.loyalty_tag && L.loyalty_tag == owner.loyalty_tag

/ai/proc/is_in_view(var/atom/A)
	return A in view(owner)

/ai/proc/can_see(var/atom/A,var/check_view = TRUE)

	if(use_cone_vision && alert_level != ALERT_LEVEL_COMBAT && !owner.is_facing(A))
		return FALSE

	if(check_view && !is_in_view(A))
		return FALSE

	if(A in attackers)
		return TRUE

	var/atom_alpha = A.alpha
	if(alert_level == ALERT_LEVEL_COMBAT)
		atom_alpha *= 2
	if(atom_alpha >= 255)
		return TRUE
	var/distance = get_dist(owner,A)
	if(distance <= 1)
		return TRUE
	if(!stored_sneak_power && is_living(owner))
		var/mob/living/L = owner
		stored_sneak_power = L.get_skill_power(SKILL_SURVIVAL)
	return A.alpha >= ((distance/VIEW_RANGE)*255*0.5) + (1 - stored_sneak_power/1)*255*0.5

/ai/proc/get_possible_targets()

	. = list()

	if(retaliate)
		. += attackers

	var/range_to_use = radius_find_enemy
	switch(alert_level)
		if(ALERT_LEVEL_NOISE)
			range_to_use = radius_find_enemy_noise
		if(ALERT_LEVEL_CAUTION)
			range_to_use = radius_find_enemy_caution
		if(ALERT_LEVEL_COMBAT)
			range_to_use = radius_find_enemy_combat

	if(range_to_use <= 0)
		return .

	if(aggression > 0)
		for(var/mob/living/L in view(range_to_use,owner))
			CHECK_TICK(75,FPS_SERVER)
			if(!can_see(L,FALSE))
				continue
			if(!should_attack_mob(L))
				continue
			.[L] = TRUE

	return .

/ai/proc/on_damage_received(var/atom/atom_damaged,var/atom/attacker,var/atom/weapon,var/list/damage_table,var/damage_amount,var/critical_hit_multiplier,var/stealthy=FALSE)

	if(is_living(attacker) && !stealthy && attacker != objective_attack)
		if(should_attack_mob(attacker))
			if(!attackers[attacker])
				attackers[attacker] = TRUE
			if(!objective_attack && !CALLBACK_EXISTS("set_new_objective_\ref[src]"))
				CALLBACK("set_new_objective_\ref[src]",reaction_time,src,.proc/set_objective,attacker)
		else if(alert_level != ALERT_LEVEL_COMBAT)
			set_alert_level(ALERT_LEVEL_CAUTION,FALSE,attacker,attacker)
			CALLBACK("investigate_\ref[src]",CEILING(reaction_time*0.5,1),src,.proc/investigate,attacker)

	return TRUE

/ai/proc/on_move(var/success,var/atom/NewLoc,Dir=0)

	if(!success)
		frustration_move++
		if(length(current_path))
			frustration_path++
		if(frustration_move >= frustration_move_threshold)
			sidestep_next = TRUE

	return TRUE

/ai/proc/Bump(var/atom/obstacle,var/trigger_other_bump=TRUE)

	if(obstacle)
		if(is_living(obstacle))
			var/mob/living/L = obstacle
			set_alert_level(ALERT_LEVEL_CAUTION,FALSE,L,L)
			if(trigger_other_bump && L.ai)
				L.ai.Bump(owner,FALSE)

		if(attack_on_block)
			spawn do_attack(obstacle,prob(left_click_chance))

	return TRUE

/ai/proc/investigate(var/atom/desired_target)

	if(!desired_target)
		return FALSE

	if(desired_target == objective_attack)
		return FALSE

	owner.set_dir(get_dir(owner,desired_target))
	objective_investigate = desired_target

	return TRUE

/ai/proc/set_alert_level(var/desired_alert_level,var/can_lower=FALSE,var/atom/alert_epicenter = null,var/atom/alert_source = null)

	if(!use_alerts)
		return FALSE

	if(owner.dead)
		return FALSE

	if(alert_level <= alert_level && alert_source && is_living(alert_source))
		var/mob/living/L = alert_source
		if(alert_level == ALERT_LEVEL_CAUTION)
			if(L == owner)
				return FALSE
		else
			if(!is_enemy(L) || radius_find_enemy <= 0 )
				return FALSE //Ignore sounds and stuff made by teammates, as well as people we do not give a fuck about.

	var/old_alert_level = alert_level

	if(can_lower)
		alert_level = desired_alert_level
	else
		alert_level = max(desired_alert_level,alert_level)

	owner.move_dir = 0

	if(old_alert_level != alert_level)
		set_active(TRUE)
		if(should_investigate_alert && alert_epicenter && (alert_level == ALERT_LEVEL_NOISE || alert_level == ALERT_LEVEL_CAUTION))
			if(!CALLBACK_EXISTS("investigate_\ref[src]")) CALLBACK("investigate_\ref[src]",CEILING(reaction_time*0.5,1),src,.proc/investigate,alert_epicenter)
		on_alert_level_changed(old_alert_level,alert_level,alert_source)
		return TRUE

	return FALSE

/ai/proc/on_alert_level_changed(var/old_alert_level,var/new_alert_level,var/atom/alert_source)

	if(owner.alert_overlay)
		if(new_alert_level == ALERT_LEVEL_COMBAT)
			owner.alert_overlay.icon_state = "exclaim"
		else if(new_alert_level == ALERT_LEVEL_CAUTION)
			owner.alert_overlay.icon_state = "question"
		else if(new_alert_level == ALERT_LEVEL_NOISE)
			owner.alert_overlay.icon_state = "huh"
		else
			owner.alert_overlay.icon_state = "none"

	return TRUE