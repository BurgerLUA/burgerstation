/damagetype/ranged/laser/kinetic
	attack_damage_base = list(
		BOMB = 100,
	)
	attack_damage_penetration = list(
		BOMB = 0,
	)


/damagetype/ranged/laser/kinetic/process_damage(atom/attacker,atom/victim,atom/weapon,atom/hit_object,atom/blamed,damage_multiplier=1)

	if(is_turf(hit_object))
		damage_multiplier *= 2 //More damage against walls.
	else if(is_living(victim))
		var/mob/living/L = victim
		if(L.size < SIZE_GIANT) //Less damage against small mobs.
			damage_multiplier *= 0.5

	. = ..()