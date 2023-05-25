/damagetype/melee/sword/grazer

	attack_damage_base = list(
		BLADE = 20,
	)

	//How much armor to penetrate. It basically removes the percentage of the armor using these values.
	attack_damage_penetration = list(
		BLADE = 25
	)

	attribute_stats = list(
		ATTRIBUTE_STRENGTH = 10,
		ATTRIBUTE_DEXTERITY = 10,
	)

	attribute_damage = list(
		ATTRIBUTE_STRENGTH = BLADE,
		ATTRIBUTE_DEXTERITY = BLADE
	)

	skill_stats = list(
		SKILL_MELEE = 10
	)

	skill_damage = list(
		SKILL_MELEE = BLADE
	)

	attack_delay = 6
	attack_delay_max = 8

/damagetype/melee/sword/grazer/on

	attack_damage_base = list(
		LASER = 25,
		HEAT = 15,
	)

	//How much armor to penetrate. It basically removes the percentage of the armor using these values.
	attack_damage_penetration = list(
		LASER = 75,
		HEAT = 75,
	)

	attribute_stats = list(
		ATTRIBUTE_STRENGTH = 10,
		ATTRIBUTE_DEXTERITY = 10,
	)

	attribute_damage = list(
		ATTRIBUTE_STRENGTH = LASER,
		ATTRIBUTE_DEXTERITY = LASER
	)

	skill_stats = list(
		SKILL_MELEE = 10
	)

	skill_damage = list(
		SKILL_MELEE = LASER
	)

	attack_delay = 8
	attack_delay_max = 10