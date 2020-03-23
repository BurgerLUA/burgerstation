/mob/living/advanced/player/add_stun(var/value,var/max_value = 40)
	drop_held_objects(src.loc)
	return ..()

/* TODO: Loyalty Implants
/mob/living/advanced/player/can_attack(var/atom/victim,var/atom/weapon,var/params)


	if(is_player(victim) && victim != src)
		if(!FRIENDLY_FIRE)
			return FALSE
		var/area/A = get_area(src)
		if(A && A.flags_area & FLAGS_AREA_NO_DAMAGE)
			return FALSE

	return ..()
*/

/mob/living/advanced/player/can_be_attacked(var/atom/attacker)

	if(is_player(attacker) && attacker != src)
		if(!FRIENDLY_FIRE)
			return FALSE
		var/area/A = get_area(src)
		if(A && A.flags_area & FLAGS_AREA_NO_DAMAGE)
			return FALSE

	return ..()