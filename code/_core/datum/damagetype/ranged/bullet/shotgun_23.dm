/damagetype/ranged/bullet/shotgun_23/buckshot
	name = "group of buckshot pellets"

	//The base attack damage of the weapon. It's a flat value, unaffected by any skills or attributes.
	attack_damage_base = list(
		BLADE = 10,
		BLUNT = 40
	)

	//How much armor to penetrate. It basically removes the percentage of the armor using these values.
	attack_damage_penetration = list(
		BLADE = 10,
		BLUNT = 10
	)

	falloff = VIEW_RANGE*0.5

	fatigue_coefficient = 1

/damagetype/ranged/bullet/shotgun_23/slug
	name = "shotgun slug"

	//The base attack damage of the weapon. It's a flat value, unaffected by any skills or attributes.
	attack_damage_base = list(
		BLUNT = 100,
		PIERCE = 20
	)

	//How much armor to penetrate. It basically removes the percentage of the armor using these values.
	attack_damage_penetration = list(
		BLUNT = 10,
		PIERCE = 10
	)

	falloff = VIEW_RANGE

	fatigue_coefficient = 0.25