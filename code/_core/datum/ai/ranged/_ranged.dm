/ai/ranged/
	name = "Ranged AI"
	radius_find_enemy = 12

/ai/ranged/handle_attacking()

	if(objective_attack)
		owner.move_dir = 0
		var/list/params = list(
			PARAM_ICON_X = num2text(pick(8,16,16,16,16,24)),
			PARAM_ICON_Y = num2text(pick(target_distribution)),
			"left" = 0,
			"right" = 0,
			"middle" = 0,
			"ctrl" = 0,
			"shift" = 0,
			"alt" = 0
		)

		params["left"] = TRUE
		owner.on_left_down(objective_attack,owner,null,params)

	attack_ticks = 0

/ai/ranged/immobile
	name = "Ranged AI - Immobile"

/ai/ranged/immobile/handle_movement()
	return FALSE

/ai/ranged/immobile/on_life()
	handle_objectives()
	handle_attacking()
	return TRUE
