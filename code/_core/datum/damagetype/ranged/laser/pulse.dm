/damagetype/ranged/laser/pulse
	name = "pulse"

	//The base attack damage of the weapon. It's a flat value, unaffected by any skills or attributes.
	attack_damage_base = list(
		LASER = DAMAGE_GREATAXE*0.75,
		HEAT = DAMAGE_GREATAXE*0.25
	)

	//How much armor to penetrate. It basically removes the percentage of the armor using these values.
	attack_damage_penetration = list(
		LASER = AP_GREATAXE,
		HEAT = 0
	)