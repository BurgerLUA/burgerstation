/ai/proc/get_sight_chance(var/atom/A,var/view_check=FALSE)

	if(owner.z != A.z)
		return 0

	if(use_cone_vision && alert_level != ALERT_LEVEL_COMBAT && !owner.is_facing(A))
		return 0

	var/true_distance = get_dist(owner,A)
	if(true_distance <= 1)
		return 100

	if(attackers[A])
		return 100

	var/vision_distance = true_distance
	if(objective_attack)
		vision_distance = get_dist(objective_attack,A) //Objective attack is the central focus point, if there is one.

	if(true_distance >= min(VIEW_RANGE+ZOOM_RANGE,radius_find_enemy_combat))
		return 0

	if(vision_distance > radius_find_enemy_combat) //We're too focused on another enemy.
		return 0

	if(view_check && !(A in view(true_distance,owner))) //I hate how expensive this is.
		return 0

	. = 100

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

	if(final_night_vision <= 0)
		. = 0
	else
		. *= clamp(atom_alpha/255,0,1) * max(final_night_vision,lightness) * 3

