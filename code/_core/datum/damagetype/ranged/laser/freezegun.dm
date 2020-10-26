/damagetype/ranged/laser/freezegun
	name = "Freeze Gun"

	//The base attack damage of the weapon. It's a flat value, unaffected by any skills or attributes.
	attack_damage_base = list(
		LASER = DAMAGE_AXE*0.25,
		COLD = DAMAGE_AXE*0.75,
	)

	//How much armor to penetrate. It basically removes the percentage of the armor using these values.
	attack_damage_penetration = list(
		COLD = AP_AXE*0.5,
		LASER = AP_AXE*0.5
	)