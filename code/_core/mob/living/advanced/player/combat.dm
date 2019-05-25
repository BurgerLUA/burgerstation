/mob/living/advanced/player/can_attack(var/atom/victim,var/params)

	world.log << "PLAYER START"

	if(is_player(victim))
		var/area/A = get_area(src)
		if(A && A.safe)
			return FALSE

	world.log << "PLAYER END"

	return ..()


/mob/living/advanced/player/can_be_attacked(var/atom/attacker)

	world.log << "TEST 2: [attacker]"

	if(is_player(attacker))
		var/area/A = get_area(src)
		if(A && A.safe)
			return FALSE

	return ..()