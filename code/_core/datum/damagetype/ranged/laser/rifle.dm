/damagetype/ranged/laser/rifle
	name = "medium laser"

	//The base attack damage of the weapon. It's a flat value, unaffected by any skills or attributes.
	attack_damage_base = list(
		LASER = DAMAGE_AXE*0.75,
		HEAT = DAMAGE_AXE*0.25
	)

	//How much armor to penetrate. It basically removes the percentage of the armor using these values.
	attack_damage_penetration = list(
		LASER = AP_AXE*0.5,
		HEAT = AP_AXE*0.5
	)

/damagetype/ranged/laser/rifle/hardlight
	name = "hardlight laser rifle"

	//The base attack damage of the weapon. It's a flat value, unaffected by any skills or attributes.
	attack_damage_base = list(
		BLUNT = DAMAGE_AXE*0.25,
		PIERCE = DAMAGE_AXE*0.25,
		LASER = DAMAGE_AXE*0.25,
		COLD = DAMAGE_AXE*0.25
	)

	//How much armor to penetrate. It basically removes the percentage of the armor using these values.
	attack_damage_penetration = list(
		BLUNT = AP_AXE*0.25,
		PIERCE = AP_AXE*0.25,
		LASER = AP_AXE*0.25,
		COLD = AP_AXE*0.25
	)

/damagetype/ranged/laser/rifle/xray
	name = "xray laser rifle"

	//The base attack damage of the weapon. It's a flat value, unaffected by any skills or attributes.
	attack_damage_base = list(
		LASER = DAMAGE_AXE*0.7,
		HEAT = DAMAGE_AXE*0.1,
		RAD = DAMAGE_AXE*0.2
	)

	//How much armor to penetrate. It basically removes the percentage of the armor using these values.
	attack_damage_penetration = list(
		LASER = INFINITY,
		HEAT = INFINITY,
		RAD = INFINITY
	)
