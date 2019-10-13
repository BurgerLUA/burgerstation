/damagetype/ranged/laser/rifle
	name = "medium laser"
	id = "laser_rifle"

	//The base attack damage of the weapon. It's a flat value, unaffected by any skills or attributes.
	attack_damage_base = list(
		PIERCE = DAMAGE_D,
		LASER = DAMAGE_C,
		HEAT = DAMAGE_C
	)

	//How much armor to penetrate. It basically removes the percentage of the armor using these values.
	attack_damage_penetration = list(
		PIERCE = ARMOR_C,
		LASER = ARMOR_C,
		HEAT = ARMOR_C
	)

/damagetype/ranged/laser/rifle/hardlight
	name = "hardlight laser rifle"
	id = "laser_rifle_hardlight"

	//The base attack damage of the weapon. It's a flat value, unaffected by any skills or attributes.
	attack_damage_base = list(
		BLADE = DAMAGE_E,
		BLUNT = DAMAGE_E,
		PIERCE = DAMAGE_D,
		LASER = DAMAGE_D,
		COLD = DAMAGE_D
	)

	//How much armor to penetrate. It basically removes the percentage of the armor using these values.
	attack_damage_penetration = list(
		BLADE = ARMOR_C,
		BLUNT = ARMOR_C,
		PIERCE = ARMOR_C,
		LASER = ARMOR_C,
		COLD = ARMOR_C
	)

/damagetype/ranged/laser/rifle/xray
	name = "xray laser rifle"
	id = "laser_rifle_xray"

	//The base attack damage of the weapon. It's a flat value, unaffected by any skills or attributes.
	attack_damage_base = list(
		LASER = DAMAGE_C,
		HEAT = DAMAGE_D,
		RAD = DAMAGE_D
	)

	//How much armor to penetrate. It basically removes the percentage of the armor using these values.
	attack_damage_penetration = list(
		LASER = ARMOR_S,
		HEAT = ARMOR_S,
		RAD = ARMOR_S
	)