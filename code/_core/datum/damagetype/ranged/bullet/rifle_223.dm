/damagetype/ranged/bullet/rifle_223
	name = ".223 rifle bullet"

	//The base attack damage of the weapon. It's a flat value, unaffected by any skills or attributes.
	attack_damage_base = list(
		BLUNT = 20,
		PIERCE = 20
	)

	//How much armor to penetrate. It basically removes the percentage of the armor using these values.
	attack_damage_penetration = list(
		BLUNT = 60,
		PIERCE = 60
	)

	falloff = VIEW_RANGE + ZOOM_RANGE

/damagetype/ranged/bullet/rifle_556mm
	name = "5.56mm rifle bullet"

	//The base attack damage of the weapon. It's a flat value, unaffected by any skills or attributes.
	attack_damage_base = list(
		BLUNT = 10,
		PIERCE = 30
	)

	//How much armor to penetrate. It basically removes the percentage of the armor using these values.
	attack_damage_penetration = list(
		BLUNT = 75,
		PIERCE = 75
	)

	falloff = VIEW_RANGE + ZOOM_RANGE

/damagetype/ranged/bullet/rifle_545mm // Is it .223-like? No. Do I care? No.
	name = "5.45mm rifle bullet"

	//The base attack damage of the weapon. It's a flat value, unaffected by any skills or attributes.
	attack_damage_base = list(
		PIERCE = 40
	)

	//How much armor to penetrate. It basically removes the percentage of the armor using these values.
	attack_damage_penetration = list(
		PIERCE = 75
	)

	falloff = VIEW_RANGE + ZOOM_RANGE

/damagetype/ranged/bullet/rifle_939mm   // Same as 5.45
	name = "9x39mm rifle bullet"

	//The base attack damage of the weapon. It's a flat value, unaffected by any skills or attributes.
	attack_damage_base = list(
		BLUNT = 45,
		PIERCE = 10
	)

	//How much armor to penetrate. It basically removes the percentage of the armor using these values.
	attack_damage_penetration = list(
		BLUNT = 70, //9x39 is very good at punching vests.
		PIERCE = 25 //9x39 is shit at piercing vests.
	)

	falloff = VIEW_RANGE + ZOOM_RANGE
