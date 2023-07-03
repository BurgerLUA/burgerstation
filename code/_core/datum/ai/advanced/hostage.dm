/ai/advanced/hostage
	enemy_tags = list()
	should_find_weapon = TRUE
	roaming_distance = 0
	resist_handcuffs = FALSE
	resist_grabs = FALSE
	enable_loc_safety = FALSE
	cowardice = 0.5
	aggression = 0
	assistance = 0

/ai/advanced/hostage/is_enemy(var/atom/A,var/safety_check=TRUE)
	if(!is_living(A))
		return ..()
	var/mob/living/L = A
	return L.ai && L.ai.objective_attack == owner
