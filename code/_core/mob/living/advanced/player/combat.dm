/mob/living/advanced/player/can_attack(var/atom/victim,var/atom/weapon,var/params)

	if(is_player(victim) && victim != src)
		var/area/A = get_area(src)
		if(A && (A.safe || A.singleplayer))
			return FALSE

	return ..()


/mob/living/advanced/player/can_be_attacked(var/atom/attacker)

	if(is_player(attacker))
		var/area/A = get_area(src)
		if(A && (A.safe || A.singleplayer))
			return FALSE

	return ..()