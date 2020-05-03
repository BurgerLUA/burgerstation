/damagetype/ranged/laser/rifle
	name = "medium laser"

	//The base attack damage of the weapon. It's a flat value, unaffected by any skills or attributes.
	attack_damage_base = list(
		HEAT = 20,
		LASER = 55
	)

	//How much armor to penetrate. It basically removes the percentage of the armor using these values.
	attack_damage_penetration = list(
		HEAT = ARMOR_C,
		LASER = ARMOR_C
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
		BLUNT = ARMOR_S,
		PIERCE = ARMOR_S,
		LASER = ARMOR_C,
		COLD = ARMOR_C
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
		LASER = ARMOR_S,
		HEAT = ARMOR_S,
		RAD = ARMOR_S
	)