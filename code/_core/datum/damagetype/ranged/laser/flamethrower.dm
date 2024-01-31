/damagetype/ranged/laser/flamethrower
	attack_damage_base = list(
		HEAT = 25
	)
	attack_damage_penetration = list(
		HEAT = 0
	)

/damagetype/ranged/laser/flamethrower/post_on_hit(atom/attacker,turf/attacker_turf,atom/victim,turf/victim_turf,atom/weapon,atom/hit_object,total_damage_dealt=0)

	if(is_living(victim))
		var/mob/living/L = victim
		L.add_status_effect(FIRE,25,0,stealthy=L.on_fire)

	. = ..()