/ai/proc/is_in_view(var/atom/A)
	return A in view(owner)

/ai/proc/get_sight_chance(var/atom/A,var/check_view = TRUE)

	if(use_cone_vision && alert_level != ALERT_LEVEL_COMBAT && !owner.is_facing(A))
		return 0

	if(check_view && !is_in_view(A))
		return 0

	if(owner.z != A.z)
		return 0

	if(A in attackers)
		return 100

	var/distance

	if(!objective_attack)
		distance = get_dist(owner,A)
	else
		distance = get_dist(objective_attack,A)

	if(distance <= 1)
		return 100

	if(distance > radius_find_enemy_combat)
		return 0

	switch(distance)
		if(1 to VIEW_RANGE)
			. = 100
		if(VIEW_RANGE to VIEW_RANGE+ZOOM_RANGE)
			. = 50
		if(VIEW_RANGE+ZOOM_RANGE to INFINITY)
			. = 25

	var/turf/T = get_turf(A)
	var/turf/T2 = get_turf(owner)

	var/lightness = 0
	switch(T.lightness)
		if(-1 to 0.5)
			lightness = 0.5 + T.lightness
		if(0.5 to 1)
			lightness = 1

	if(T2.lightness < T.lightness - 0.25)
		lightness *= 2

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

	return .