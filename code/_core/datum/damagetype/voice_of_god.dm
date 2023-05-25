/damagetype/voice_of_god/harm
	attack_damage_base = list(
		DARK = 50,
	)

/damagetype/voice_of_god/kill
	attack_damage_base = list(
		DARK = 250,
	)

/damagetype/voice_of_god/kill/post_on_hit(var/atom/attacker,var/turf/attacker_turf,var/atom/victim,var/turf/victim_turf,var/atom/weapon,var/atom/hit_object,var/total_damage_dealt=0)

	. = ..()

	if(is_living(victim))
		var/mob/living/L = victim
		L.death()