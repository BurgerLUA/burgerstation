/ai/proc/get_detection_level(var/atom/A,var/view_check=FALSE) //Returns a value 0 to 1.

	if(owner.z != A.z)
		return 0 //Cannot see people who aren't even on your z-level.

	if(use_cone_vision && alert_level != ALERT_LEVEL_COMBAT && !is_facing(owner,A))
		return 0 //Cannot see those not in your cone range, unless you're in combat.

	var/true_distance = get_dist(owner,A)
	if(true_distance <= 1)
		return 1 //Can always see people right next to them (unless above says otherwise)

	var/vision_distance = true_distance
	if(objective_attack)
		vision_distance = get_dist(A,objective_attack) //Objective attack is the central focus point, if there is one.
		vision_distance = max(vision_distance,0)

	if(true_distance >= min(VIEW_RANGE+ZOOM_RANGE*2,radius_find_enemy_combat))
		return FALSE //Never be able to see what is impossible for a player.

	var/turf/T_owner = get_turf(owner)
	var/turf/T_atom = get_turf(A)

	if(!see_through_walls && view_check && !T_owner.is_straight_path_to(T_atom,check_vision=TRUE,check_density=FALSE))
		return 0 //Never be able to see through walls.

	//Lightness calculations
	var/lightness = T_atom.lightness
	if(ismovable(A))
		var/atom/movable/M = A
		if(length(M.light_sprite_sources)) //Target has has a flashlight on. Lightness is irrelevant.
			lightness = 1
	lightness = max(0,lightness)
	lightness = lightness/night_vision
	lightness = COSINE_CURVE(lightness)

	// https://www.desmos.com/calculator/mc4gs7eia1
	. = 2 * (0.5 + src.stored_sneak_power) * (1 - ((vision_distance**0.9)-1)/VIEW_RANGE)*(lightness**0.7)

	if(!src.true_sight && is_living(A))
		var/mob/living/L = A
		if(L.is_sneaking)
			. *= 0.75

	if(debug && ismob(A))
		var/mob/M = A
		if(M.client)
			M.to_chat(span("debug","[M.name] detection: [.]"))

	if(use_blood_sight && owner.health)
		. += clamp(0.5 - owner.health.health_current/owner.health.health_max,0,0.25)

	return