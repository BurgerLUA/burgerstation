/ai/silicon_spawner

	radius_find_enemy = VIEW_RANGE
	radius_find_enemy_noise = VIEW_RANGE
	radius_find_enemy_caution = VIEW_RANGE + ZOOM_RANGE
	radius_find_enemy_combat = VIEW_RANGE + ZOOM_RANGE

	distance_target_max = VIEW_RANGE + ZOOM_RANGE*3

	roaming_distance = 0

	use_cone_vision = TRUE

	aggression = 3
	assistance = 1

	can_attack = FALSE

/ai/silicon_spawner/set_objective(atom/A)

	. = ..()

	if(. && objective_attack)
		var/mob/living/simple/silicon/spawner/SP = owner
		if(SP.has_stored_cyborg)
			SP.create_silicon()
		else if(!CALLBACK_EXISTS("\ref[SP]_create_silicon") && !CALLBACK_EXISTS("\ref[SP]_start_creating"))
			SP.start_creating()