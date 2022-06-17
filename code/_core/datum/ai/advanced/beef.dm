/ai/advanced/beef
	ignore_immortal = TRUE
	should_find_weapon = FALSE
	roaming_distance = VIEW_RANGE

	var/mob/living/hunt_target //Will try to chase this target.

/ai/advanced/beef/on_life(var/tick_rate=1)

	. = ..()

	if(!. || objective_attack || !hunt_target || current_path || current_path_astar)
		return .

	var/turf/desired_target_turf = get_step(hunt_target,turn(hunt_target.dir,180))

	if(!desired_target_turf)
		return TRUE

	var/turf/current_turf = get_turf(owner)

	if(!current_turf)
		return TRUE

	var/target_distance = get_dist(current_turf,desired_target_turf)

	if(target_distance <= 1)
		return TRUE

	if(target_distance >= VIEW_RANGE)
		var/obj/marker/map_node/N_start = find_closest_node(current_turf)
		var/obj/marker/map_node/N_end = N_start ? find_closest_node(desired_target_turf) : null
		var/list/obj/marker/map_node/found_path = N_end ? N_start.find_path(N_end) : null
		if(found_path)
			set_path(found_path)
			return TRUE

	set_path_astar(desired_target_turf)

	return TRUE

/ai/advanced/beef/check_aggression(var/mob/living/target,var/aggression_override = src.aggression)

	if(target == hunt_target)
		return is_facing(target,owner)

	return check_aggression(target)
