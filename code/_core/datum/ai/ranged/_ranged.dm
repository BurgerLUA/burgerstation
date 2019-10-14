/ai/ranged/
	name = "Ranged AI"
	radius_find_enemy = 12

/ai/ranged/immobile
	name = "Ranged AI - Immobile"

/ai/ranged/immobile/handle_movement()
	return FALSE

/ai/ranged/immobile/on_life()
	handle_objectives()
	handle_attacking()
	return TRUE
