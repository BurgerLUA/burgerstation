/atom/movable/can_attack(var/atom/attacker,var/atom/victim,var/atom/weapon,var/params,var/damagetype/damage_type)
	if(attacker && !is_turf(attacker.loc))
		return FALSE
	. = ..()