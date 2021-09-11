/damagetype/ranged/laser/kinetic
	attack_damage_base = list(
		BOMB = 100,
	)
	attack_damage_penetration = list(
		BOMB = 75,
	)


/damagetype/ranged/laser/kinetic/process_damage(var/atom/attacker,var/atom/victim,var/atom/weapon,var/atom/hit_object,var/atom/blamed,var/damage_multiplier=1)

	if(isturf(hit_object))
		damage_multiplier *= 2 //More damage against walls.
	else if(is_living(victim))
		var/mob/living/L = victim
		if(L.size < SIZE_GIANT) //Less damage against small mobs.
			damage_multiplier *= 0.5

	. = ..()