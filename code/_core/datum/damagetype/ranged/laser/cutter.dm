/damagetype/ranged/laser/plasma_cutter
	attack_damage_base = list(
		PIERCE = 60,
		HEAT = 20
	)
	attack_damage_penetration = list(
		PIERCE = 75,
		HEAT = 40
	)


/damagetype/ranged/laser/plasma_cutter/process_damage(var/atom/attacker,var/atom/victim,var/atom/weapon,var/atom/hit_object,var/atom/blamed,var/damage_multiplier=1)

	if(isturf(hit_object))
		damage_multiplier *= 8 //More damage against walls.

	. = ..()