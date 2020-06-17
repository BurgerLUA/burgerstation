/ai/advanced/hostage
	enemy_tags = list()
	should_find_weapon = TRUE
	roaming_distance = 0

/ai/advanced/hostage/is_enemy(var/mob/living/L)
	return L.ai && L.ai.objective_attack == owner