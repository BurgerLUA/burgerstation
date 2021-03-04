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
	var/lightness = min(T.lightness/night_vision,1)
	if(ismovable(A))
		var/atom/movable/M = A
		if(length(M.light_sprite_sources))
			lightness = 3

	var/atom_alpha = A.alpha
	switch(alert_level)
		if(ALERT_LEVEL_COMBAT)
			atom_alpha += 50
			atom_alpha *= 2
			lightness *= 2
		if(ALERT_LEVEL_CAUTION)
			atom_alpha += 25
			atom_alpha *= 1.5
			lightness *= 1.5
		if(ALERT_LEVEL_NOISE)
			atom_alpha += 10
			atom_alpha *= 1.25
			lightness *= 1.25

	if(A == objective_attack)
		atom_alpha += 50
		atom_alpha *= 2

	. *= clamp(atom_alpha/255,0,1) * lightness

