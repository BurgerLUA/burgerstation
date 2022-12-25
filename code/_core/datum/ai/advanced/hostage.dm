/ai/advanced/hostage
	enemy_tags = list()
	should_find_weapon = TRUE
	roaming_distance = 0
	resist_handcuffs = FALSE
	enable_loc_safety = FALSE

/ai/advanced/hostage/is_enemy(var/atom/A,var/safety_check=TRUE)
	if(!is_living(A))
		return ..()
	var/mob/living/L = A
	return L.ai && L.ai.objective_attack == owner

/ai/advanced/hostage/set_path(var/list/Vector3D/desired_path = list())

	if(node_path_end_turf && !desired_path)
		var/obj/marker/hostage_rest/HR = locate() in view(VIEW_RANGE,owner)
		if(HR)
			home_turf = get_turf(HR)
			roaming_distance = 0
		else
			home_turf = node_path_end_turf
			roaming_distance = 8

	return ..()