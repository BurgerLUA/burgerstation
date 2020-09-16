/damagetype/ranged/laser/rifle
	name = "medium laser"

	//The base attack damage of the weapon. It's a flat value, unaffected by any skills or attributes.
	attack_damage_base = list(
		LASER = 30,
		HEAT = 30
	)

	//How much armor to penetrate. It basically removes the percentage of the armor using these values.
	attack_damage_penetration = list(
		LASER = 10,
		HEAT = 10
	)

/damagetype/ranged/laser/rifle/hardlight
	name = "hardlight laser rifle"

	//The base attack damage of the weapon. It's a flat value, unaffected by any skills or attributes.
	attack_damage_base = list(
		BLUNT = 10,
		PIERCE = 10,
		LASER = 20,
		COLD = 10
	)

	//How much armor to penetrate. It basically removes the percentage of the armor using these values.
	attack_damage_penetration = list(
		BLUNT = 75,
		PIERCE = 75,
		LASER = 25,
		COLD = 25
	)

/damagetype/ranged/laser/rifle/xray
	name = "xray laser rifle"

	//The base attack damage of the weapon. It's a flat value, unaffected by any skills or attributes.
	attack_damage_base = list(
		LASER = 10,
		HEAT = 20,
		RAD = 20
	)

	//How much armor to penetrate. It basically removes the percentage of the armor using these values.
	attack_damage_penetration = list(
		LASER = INFINITY,
		HEAT = INFINITY,
		RAD = INFINITY
	)