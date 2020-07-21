/damagetype/ranged/bullet/rifle_308
	name = ".308 rifle bullet"

	//The base attack damage of the weapon. It's a flat value, unaffected by any skills or attributes.
	attack_damage_base = list(
		BLUNT = 30,
		PIERCE = 30
	)

	//How much armor to penetrate. It basically removes the percentage of the armor using these values.
	attack_damage_penetration = list(
		BLUNT = 35,
		PIERCE = 35
	)

	falloff = VIEW_RANGE + ZOOM_RANGE*3

/damagetype/ranged/bullet/rifle_762mm
	name = "7.62mm rifle bullet"

	//The base attack damage of the weapon. It's a flat value, unaffected by any skills or attributes.
	attack_damage_base = list(
		BLUNT = 30,
		PIERCE = 30
	)

	//How much armor to penetrate. It basically removes the percentage of the armor using these values.
	attack_damage_penetration = list(
		BLUNT = 35,
		PIERCE = 35
	)

	falloff = VIEW_RANGE + ZOOM_RANGE*3


/damagetype/ranged/bullet/rifle_762mm/short
	name = "7.62mm short rifle bullet"

	//The base attack damage of the weapon. It's a flat value, unaffected by any skills or attributes.
	attack_damage_base = list(
		BLUNT = 30,
		PIERCE = 20
	)

	//How much armor to penetrate. It basically removes the percentage of the armor using these values.
	attack_damage_penetration = list(
		BLUNT = 35,
		PIERCE = 35
	)

	falloff = VIEW_RANGE + ZOOM_RANGE

/damagetype/ranged/bullet/rifle_762mm/long
	name = "7.62mm long rifle bullet"

	//The base attack damage of the weapon. It's a flat value, unaffected by any skills or attributes.
	attack_damage_base = list(
		BLUNT = 20,
		PIERCE = 40
	)

	//How much armor to penetrate. It basically removes the percentage of the armor using these values.
	attack_damage_penetration = list(
		BLUNT = 45,
		PIERCE = 45
	)

	falloff = VIEW_RANGE + ZOOM_RANGE*3