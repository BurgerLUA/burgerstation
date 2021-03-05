/ai/proc/get_sight_chance(var/atom/A,var/check_view = TRUE)

	if(owner.z != A.z)
		return 0

	if(use_cone_vision && alert_level != ALERT_LEVEL_COMBAT && !owner.is_facing(A))
		return 0

	if(check_view)
		var/view_range_to_use = get_view_range()
		if(!(owner in viewers(view_range_to_use,A)))
			return 0

	if(A in attackers)
		return 100

	var/true_distance = get_dist(owner,A)
	if(true_distance <= 1)
		return 100

	var/vision_distance = true_distance
	if(objective_attack)
		vision_distance = get_dist(objective_attack,A) //Objective attack is the central focus point.

	if(true_distance > radius_find_enemy_combat)
		return 0

	if(vision_distance > radius_find_enemy_combat)
		return 0

	switch(vision_distance)
		if(1 to VIEW_RANGE*0.75)
			. = 100
		if(VIEW_RANGE*0.75 to VIEW_RANGE+ZOOM_RANGE)
			. = 50
		if(VIEW_RANGE+ZOOM_RANGE to INFINITY)
			. = 10

	var/turf/T = get_turf(A)
	var/lightness = T.lightness
	if(ismovable(A))
		var/atom/movable/M = A
		if(length(M.light_sprite_sources))
			lightness = 3
	var/final_night_vision = night_vision
	var/atom_alpha = A.alpha
	switch(alert_level)
		if(ALERT_LEVEL_COMBAT)
			final_night_vision *= 4
			atom_alpha *= 4
		if(ALERT_LEVEL_CAUTION)
			final_night_vision *= 3
			atom_alpha *= 3
		if(ALERT_LEVEL_NOISE)
			final_night_vision *= 2
			atom_alpha *= 2

	. *= clamp(atom_alpha/255,0,1) * (lightness/final_night_vision)

