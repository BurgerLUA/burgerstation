/damagetype/ranged/laser/plasma_cutter
	attack_damage_base = list(
		PIERCE = 30,
		HEAT = 10
	)
	attack_damage_penetration = list(
		PIERCE = 100,
		HEAT = 100
	)


/damagetype/ranged/laser/plasma_cutter/process_damage(var/atom/attacker,var/atom/victim,var/atom/weapon,var/atom/hit_object,var/atom/blamed,var/damage_multiplier=1)

	if(is_turf(hit_object))
		damage_multiplier *= 8 //More damage against walls.

	. = ..()