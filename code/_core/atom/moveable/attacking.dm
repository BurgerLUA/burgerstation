/atom/movable/can_attack(var/atom/attacker,var/atom/victim,var/atom/weapon,var/params,var/damagetype/damage_type)

	if(!isturf(attacker.loc))
		return FALSE

	. = ..()


/atom/movable/can_be_attacked(var/atom/attacker,var/atom/weapon,var/params,var/damagetype/damage_type)

	if(!isturf(src.loc))
		return FALSE

	. = ..()