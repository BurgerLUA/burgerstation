/damagetype/ranged/laser/plasma_cutter
	name = "plasma burst" //based game btw

	//The base attack damage of the weapon. It's a flat value, unaffected by any skills or attributes.
	attack_damage_base = list(
		PIERCE = 30,
		HEAT = 20
	)

	//How much armor to penetrate. It basically removes the percentage of the armor using these values.
	attack_damage_penetration = list(
		PIERCE = 75,
		HEAT = 40
	)


/damagetype/ranged/laser/cutter/process_damage(var/atom/attacker,var/atom/victim,var/atom/weapon,var/atom/hit_object,var/atom/blamed,var/damage_multiplier=1)

	if(isturf(hit_object))
		damage_multiplier *= 8 //More damage against walls.
	else if(is_living(hit_object))
		var/mob/living/L = hit_object
		if(L.size < SIZE_GIANT)
			damage_multiplier *= 1

	. = ..()