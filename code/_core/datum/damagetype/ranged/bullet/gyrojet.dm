/damagetype/ranged/bullet/gyrojet/
	attack_damage_base = list(
		BLUNT = 10,
	)
	attack_damage_penetration = list(
		BLUNT = 0
	)
	falloff = 0

/damagetype/ranged/bullet/gyrojet/rubber_grenade
	attack_damage_base = list(
		BLUNT = 10,
	)
	attack_damage_penetration = list(
		BLUNT = 0
	)
	falloff = 0

/damagetype/ranged/bullet/gyrojet/rubber_grenade/post_on_hit(atom/attacker,turf/attacker_turf,atom/victim,turf/victim_turf,atom/weapon,atom/hit_object,total_damage_dealt=0)
	if(is_living(victim)&& victim.health)
		var/mob/living/V = victim
		V.health.adjust_stamina(-75)
	. = ..()

/damagetype/ranged/bullet/gyrojet/hv
	attack_damage_base = list(
		BLUNT = 250
	)
	attack_damage_penetration = list(
		BLUNT = 125
	)
	falloff = 0