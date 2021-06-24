/damagetype/npc/goliath_tentacle //No skill
	name = "goliath tentacle"

	//The base attack damage of the weapon. It's a flat value, unaffected by any skills or attributes.
	attack_damage_base = list(
		BLADE = 45*0.25,
		BLUNT = 45*0.1,
		PIERCE = 45*0.35,
		DARK = 45*0.3
	)

	//How much armor to penetrate. It basically removes the percentage of the armor using these values.
	attack_damage_penetration = list(
		BLADE = 40*0.25,
		BLUNT = 40*0.25,
		PIERCE = 40*0.25,
		DARK = 40*0.25
	)

	attack_delay = 12*0.5
	attack_delay_max = 12