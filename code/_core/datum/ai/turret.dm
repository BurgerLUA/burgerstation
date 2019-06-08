/ai/ranged/immobile/turret
	name = "Turret AI"
	radius_find_enemy = 12
	attack_delay = 8

/ai/ranged/immobile/turret/handle_objectives()
	. = ..()

	if(!is_turret(owner))
		return .

	var/mob/living/simple/npc/turret/T = owner
	if(objective_attack)
		T.open()
		T.face_atom(objective_attack)
	else
		T.close()