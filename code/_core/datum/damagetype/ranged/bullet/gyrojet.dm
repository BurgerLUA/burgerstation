/damagetype/ranged/bullet/gyrojet/
	name = "Gyrojet Impact"

	//The base attack damage of the weapon. It's a flat value, unaffected by any skills or attributes.
	attack_damage_base = list(
		BLUNT = 15*0.75,
		PIERCE = 15*0.25,
	)

	//How much armor to penetrate. It basically removes the percentage of the armor using these values.
	attack_damage_penetration = list(
		BLUNT = 10*0.75,
		PIERCE = 10*0.25,
	)

	falloff = 0