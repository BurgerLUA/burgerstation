/damagetype/ranged/bullet/rifle_223
	name = ".223 rifle bullet"

	//The base attack damage of the weapon. It's a flat value, unaffected by any skills or attributes.
	attack_damage_base = list(
		BLUNT = 10,
		PIERCE = 30
	)

	//How much armor to penetrate. It basically removes the percentage of the armor using these values.
	attack_damage_penetration = list(
		BLUNT = 45,
		PIERCE = 45
	)

	falloff = VIEW_RANGE + ZOOM_RANGE

/damagetype/ranged/bullet/rifle_556mm
	name = "5.56mm rifle bullet"

	//The base attack damage of the weapon. It's a flat value, unaffected by any skills or attributes.
	attack_damage_base = list(
		PIERCE = 40
	)

	//How much armor to penetrate. It basically removes the percentage of the armor using these values.
	attack_damage_penetration = list(
		PIERCE = 45
	)

	falloff = VIEW_RANGE + ZOOM_RANGE*0.5

/damagetype/ranged/bullet/rifle_545mm
	name = "5.45mm rifle bullet"

	//The base attack damage of the weapon. It's a flat value, unaffected by any skills or attributes.
	attack_damage_base = list(
		PIERCE = 30
	)

	//How much armor to penetrate. It basically removes the percentage of the armor using these values.
	attack_damage_penetration = list(
		PIERCE = 50
	)

	falloff = VIEW_RANGE + ZOOM_RANGE

/damagetype/ranged/bullet/rifle_939mm
	name = "9x39mm subsonic rifle bullet"

	//The base attack damage of the weapon. It's a flat value, unaffected by any skills or attributes.
	attack_damage_base = list(
		BLUNT = 25,
		PIERCE = 10
	)

	//How much armor to penetrate. It basically removes the percentage of the armor using these values.
	attack_damage_penetration = list(
		BLUNT = 25,
		PIERCE = 25
	)

	falloff = VIEW_RANGE
