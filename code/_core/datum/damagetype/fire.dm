/damagetype/on_fire/
	name = "on fire"

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

/damagetype/on_fire/do_attack_animation(var/atom/attacker,var/atom/victim,var/atom/weapon,var/atom/hit_object)
	return FALSE