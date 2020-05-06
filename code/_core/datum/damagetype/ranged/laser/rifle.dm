/damagetype/ranged/laser/rifle
	name = "medium laser"

	//The base attack damage of the weapon. It's a flat value, unaffected by any skills or attributes.
	attack_damage_base = list(
		HEAT = 20,
		LASER = 55
	)

	//How much armor to penetrate. It basically removes the percentage of the armor using these values.
	attack_damage_penetration = list(
		HEAT = 25,
		LASER = 25
	)

/damagetype/ranged/laser/rifle/hardlight
	name = "hardlight laser rifle"

	//The base attack damage of the weapon. It's a flat value, unaffected by any skills or attributes.
	attack_damage_base = list(
		BLUNT = 15,
		PIERCE = 15,
		LASER = 10,
		COLD = 10
	)

	//How much armor to penetrate. It basically removes the percentage of the armor using these values.
	attack_damage_penetration = list(
		BLUNT = 100,
		PIERCE = 100,
		LASER = 25,
		COLD = 25
	)

/damagetype/ranged/laser/rifle/xray
	name = "xray laser rifle"

	//The base attack damage of the weapon. It's a flat value, unaffected by any skills or attributes.
	attack_damage_base = list(
		LASER = 30,
		HEAT = 10,
		RAD = 10
	)

	//How much armor to penetrate. It basically removes the percentage of the armor using these values.
	attack_damage_penetration = list(
		LASER = 100,
		HEAT = 100,
		RAD = 100
	)