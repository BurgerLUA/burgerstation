/ai/proc/get_detection_level(var/atom/A,var/view_check=FALSE) //Returns a value 0 to 1.

	var/turf/T_owner = get_turf(owner)
	var/turf/T_atom = get_turf(A)

	if(T_owner.z != T_atom.z)
		return 0 //Cannot see people who aren't even on your z-level.

	if(use_cone_vision && alert_level != ALERT_LEVEL_COMBAT && !is_facing(owner,A))
		return 0 //Cannot see those not in your cone range, unless you're in combat.

	var/true_distance = get_dist(T_owner,T_atom)
	if(true_distance <= 1)
		return 1 //Can always see people right next to them (unless above says otherwise)
	else if(true_distance >= min(VIEW_RANGE+ZOOM_RANGE*2,radius_find_enemy_combat))
		return FALSE //Never be able to see what is impossible for a player.

	var/vision_distance = true_distance
	if(objective_attack) //We have an objective attack.
		var/turf/T_objective = A == objective_attack ? T_atom : get_turf(objective_attack)
		vision_distance = get_dist(T_atom,T_objective) //Objective attack is the central focus point, if there is one.
		vision_distance = max(vision_distance,0)

	if(view_check && !see_through_walls && !T_owner.is_straight_path_to(T_atom,check_vision=TRUE,check_density=FALSE))
		return 0 //Never be able to see through walls.

	//Lightness calculations
	var/lightness = T_atom.lightness
	if(ismovable(A))
		var/atom/movable/M = A
		if(length(M.light_sprite_sources)) //Target has has a flashlight on. Lightness is irrelevant.
			lightness = 1
	lightness = COSINE_CURVE(lightness)

	// https://www.desmos.com/calculator/bbvdmhbfao
	. = 2 * (0.5 + src.stored_sneak_power) * (1 - ((vision_distance**0.6)-1)/VIEW_RANGE)*(min(1,lightness+night_vision)**0.6)

	if(!src.true_sight && is_living(A))
		var/mob/living/L = A
		if(L.is_sneaking)
			. *= 0.75
		if(!L.z && L != objective_attack && !knows_about_lockers)
			. *= 0.25

	if(A == hunt_target)
		. += 0.5

	if(debug && ismob(A))
		var/mob/M = A
		if(M.client)
			M.to_chat(span("debug","[M.name] detection: [.]"))

	if(use_blood_sight && owner.health)
		. += clamp(0.5 - owner.health.health_current/owner.health.health_max,0,0.25)