/damagetype/ranged/laser/rifle
	name = "medium laser"

	//The base attack damage of the weapon. It's a flat value, unaffected by any skills or attributes.
	attack_damage_base = list(
		LASER = 50,
		HEAT = 10
	)

	//How much armor to penetrate. It basically removes the percentage of the armor using these values.
	attack_damage_penetration = list(
		LASER = 25,
		HEAT = 25
	)

/damagetype/ranged/laser/rifle/hardlight
	name = "hardlight laser rifle"

	//The base attack damage of the weapon. It's a flat value, unaffected by any skills or attributes.
	attack_damage_base = list(
		BLUNT = 10,
		PIERCE = 30,
		LASER = 10,
		COLD = 10
	)

	//How much armor to penetrate. It basically removes the percentage of the armor using these values.
	attack_damage_penetration = list(
		BLUNT = 50,
		PIERCE = 50,
		LASER = 50,
		COLD = 50
	)

/damagetype/ranged/laser/rifle/xray
	name = "xray laser rifle"

	//The base attack damage of the weapon. It's a flat value, unaffected by any skills or attributes.
	attack_damage_base = list(
		LASER = 30,
		HEAT = 10,
		RAD = 30
	)

	//How much armor to penetrate. It basically removes the percentage of the armor using these values.
	attack_damage_penetration = list(
		LASER = 200,
		HEAT = 200,
		RAD = 200
	)
