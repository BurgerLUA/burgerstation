/atom/movable/can_attack(var/atom/attacker,var/atom/victim,var/atom/weapon,var/params,var/damagetype/damage_type)
	if(attacker && !isturf(attacker.loc))
		return FALSE
	. = ..()