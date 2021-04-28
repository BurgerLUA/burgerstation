//Explosion damage follows this graph: https://www.desmos.com/calculator/ia1lj88rdt
//Calculated in do_explosion_damage().

/damagetype/explosion/
	name = "explosion"

	//The base attack damage of the weapon. It's a flat value, unaffected by any skills or attributes.
	attack_damage_base = list(
		BOMB = 30,
	)

	//How much armor to penetrate. It basically removes the percentage of the armor using these values.
	attack_damage_penetration = list(
		BOMB = 0,
	)

	hit_effect = null

	can_be_parried = FALSE

	impact_sounds = null

	target_floors = TRUE