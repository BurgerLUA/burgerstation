/damagetype/ranged/laser/kinetic
	name = "kinetic accelerator"

	//The base attack damage of the weapon. It's a flat value, unaffected by any skills or attributes.
	attack_damage_base = list(
		BOMB = 100,
	)

	//How much armor to penetrate. It basically removes the percentage of the armor using these values.
	attack_damage_penetration = list(
		BOMB = 50,
	)


/damagetype/ranged/laser/kinetic/process_damage(var/atom/attacker,var/atom/victim,var/atom/weapon,var/atom/hit_object,var/atom/blamed,var/damage_multiplier=1)

	if(hit_object && hit_object.health && hit_object.health.organic)
		damage_multiplier *= 0.25

	. = ..()