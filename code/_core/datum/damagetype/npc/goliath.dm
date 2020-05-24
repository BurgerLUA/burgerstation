/damagetype/npc/goliath_tentacle
	name = "goliath tentacle"

	//The base attack damage of the weapon. It's a flat value, unaffected by any skills or attributes.
	attack_damage_base = list(
		BLADE = 25,
		BLUNT = 10,
		PIERCE = 25,
		DARK = 10
	)

	//How much armor to penetrate. It basically removes the percentage of the armor using these values.
	attack_damage_penetration = list(
		BLADE = 25,
		BLUNT = 25,
		PIERCE = 25,
		DARK = 60
	)