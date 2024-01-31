/damagetype/voice_of_god/harm
	attack_damage_base = list(
		DARK = 50,
	)

/damagetype/voice_of_god/kill
	attack_damage_base = list(
		DARK = 250,
	)

/damagetype/voice_of_god/kill/post_on_hit(atom/attacker,turf/attacker_turf,atom/victim,turf/victim_turf,atom/weapon,atom/hit_object,total_damage_dealt=0)

	. = ..()

	if(is_living(victim))
		var/mob/living/L = victim
		L.death()