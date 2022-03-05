//swarmerdamagefile

/damagetype/npc/swarmer
	name = "stabby bits"

	attack_damage_base = list(
		FATIGUE = 10,
		ION = 10,
		LASER = 20
	)

	attack_damage_penetration = list(
		FATIGUE = 75
	)

/damagetype/ranged/swarmerstun
	name = "disabler beam"

	attack_damage_base = list(
		FATIGUE = 25,
		ION = 10
	)

	attack_damage_penetration = list(
		FATIGUE = 75
	)
