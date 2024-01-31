/atom/movable/can_attack(atom/attacker,atom/victim,atom/weapon,params,damagetype/damage_type)
	if(attacker && !is_turf(attacker.loc))
		return FALSE
	. = ..()