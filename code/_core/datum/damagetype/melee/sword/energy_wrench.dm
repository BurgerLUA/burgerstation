/damagetype/melee/sword/energy_wrench
	name = "inactive wrench"

	attack_damage_base = list(
		BLUNT = 15,
	)

	//How much armor to penetrate. It basically removes the percentage of the armor using these values.
	attack_damage_penetration = list(
		BLUNT = 0
	)

	attribute_stats = list(
		ATTRIBUTE_STRENGTH = 0,
		ATTRIBUTE_DEXTERITY = 0,
	)

	attribute_damage = list(
		ATTRIBUTE_STRENGTH = BLUNT,
		ATTRIBUTE_DEXTERITY = BLUNT
	)

	skill_stats = list(
		SKILL_MELEE = 0
	)

	skill_damage = list(
		SKILL_MELEE = BLUNT
	)

	attack_delay = 6
	attack_delay_max = 8

/damagetype/melee/sword/energy_wrench/on
	name = "active wrench"

	attack_damage_base = list(
		BLUNT = 10,
		LASER = 30,
		HEAT = 10,
	)

	//How much armor to penetrate. It basically removes the percentage of the armor using these values.
	attack_damage_penetration = list(
		BLUNT = 75,
		LASER = 75,
		HEAT = 75,
	)

	attribute_stats = list(
		ATTRIBUTE_STRENGTH = 10,
		ATTRIBUTE_DEXTERITY = 10,
	)

	attribute_damage = list(
		ATTRIBUTE_STRENGTH = list(BLUNT,LASER),
		ATTRIBUTE_DEXTERITY = list(BLUNT,LASER)
	)

	skill_stats = list(
		SKILL_MELEE = 10
	)

	skill_damage = list(
		SKILL_MELEE = list(BLUNT,LASER)
	)

	attack_delay = 8
	attack_delay_max = 10