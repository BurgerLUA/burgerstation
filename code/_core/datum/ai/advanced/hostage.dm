/ai/advanced/hostage
	enemy_tags = list()
	should_find_weapon = TRUE
	roaming_distance = 0
	resist_handcuffs = FALSE
	enable_loc_safety = FALSE
	cowardice = 0.5
	aggression = 0
	assistance = 0

/ai/advanced/hostage/is_enemy(var/atom/A,var/safety_check=TRUE)
	if(!is_living(A))
		return ..()
	var/mob/living/L = A
	return L.ai && L.ai.objective_attack == owner

/ai/advanced/hostage/set_path_node(var/list/obj/marker/map_node/desired_path)

	. = ..()

	if(node_path_end_turf && !desired_path)
		var/obj/marker/hostage_rest/HR = locate() in view(VIEW_RANGE,owner)
		if(HR)
			home_turf = get_turf(HR)
			roaming_distance = 0
		else
			home_turf = node_path_end_turf
			roaming_distance = 8
