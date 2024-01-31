/damagetype/on_fire/

	impact_sounds = list()
	miss_sounds = list()
	hit_effect = null


	//The base attack damage of the weapon. It's a flat value, unaffected by any skills or attributes.
	attack_damage_base = list(
		HEAT = 1,
	)

	//How much armor to penetrate. It basically removes the percentage of the armor using these values.
	attack_damage_penetration = list(
		HEAT = 25
	)

	attribute_stats = list(

	)

	attribute_damage = list(

	)

	skill_stats = list(

	)

	skill_damage = list(

	)

	target_floors = TRUE
	enable_logs = 1
	allow_damage_numbers = FALSE

/damagetype/on_fire/do_attack_animation(atom/attacker,atom/victim,atom/weapon,atom/hit_object)
	return FALSE


/damagetype/fire_turf

	impact_sounds = list()
	miss_sounds = list()
	hit_effect = null

	//The base attack damage of the weapon. It's a flat value, unaffected by any skills or attributes.
	attack_damage_base = list(
		HEAT = 20,
	)

	//How much armor to penetrate. It basically removes the percentage of the armor using these values.
	attack_damage_penetration = list(
		HEAT = 25
	)

	target_floors = TRUE
	enable_logs = 1
	allow_damage_numbers = FALSE


/damagetype/fire_turf/post_on_hit(atom/attacker,turf/attacker_turf,atom/victim,turf/victim_turf,atom/weapon,atom/hit_object,total_damage_dealt=0)

	if(is_living(victim))
		var/mob/living/L = victim
		L.ignite(50,source=attacker)

	. = ..()