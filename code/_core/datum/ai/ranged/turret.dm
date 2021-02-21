/ai/ranged/immobile/turret
	radius_find_enemy = VIEW_RANGE
	attack_delay = 8

/ai/ranged/immobile/turret/handle_objectives()
	. = ..()

	if(objective_attack)
		owner.face_atom(objective_attack)

/ai/ranged/immobile/turret/port/handle_objectives()

	. = ..()

	var/mob/living/simple/npc/turret/port/T = owner
	if(objective_attack)
		T.open()
	else
		T.close()

	