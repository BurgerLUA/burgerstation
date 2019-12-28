/ai/ranged/
	radius_find_enemy = 12

/ai/ranged/immobile

/ai/ranged/immobile/handle_movement()
	return FALSE

/ai/ranged/immobile/on_life()
	handle_objectives()
	handle_attacking()
	return TRUE
