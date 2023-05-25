/damagetype/melee/club/stunbaton

	//The base attack damage of the weapon. It's a flat value, unaffected by any skills or attributes.
	attack_damage_base = list(
		BLUNT = 35
	)

	attribute_stats = list(
		ATTRIBUTE_STRENGTH = 40,
		ATTRIBUTE_DEXTERITY = 10
	)

	attribute_damage = list(
		ATTRIBUTE_STRENGTH = BLUNT,
		ATTRIBUTE_DEXTERITY = BLUNT
	)

	skill_stats = list(
		SKILL_MELEE = 5
	)

	skill_damage = list(
		SKILL_MELEE = BLUNT
	)

	attack_delay = 10
	attack_delay_max = 15

/damagetype/melee/club/stunbaton/on

	//The base attack damage of the weapon. It's a flat value, unaffected by any skills or attributes.
	attack_damage_base = list(
		FATIGUE = 50,
		ION = 10
	)

	//How much armor to penetrate. It basically removes the percentage of the armor using these values.
	attack_damage_penetration = list(
		FATIGUE = 75
	)

	attribute_stats = list()

	attribute_damage = list()

	skill_stats = list()

	skill_damage = list()

	attack_delay = 8
	attack_delay_max = 12


/damagetype/melee/club/stunbaton/on/harm

	//The base attack damage of the weapon. It's a flat value, unaffected by any skills or attributes.
	attack_damage_base = list(
		BLUNT = 20,
		FATIGUE = 30,
		ION = 10
	)

	attack_damage_penetration = list(
		BLUNT = 25,
		FATIGUE = 0,
		ION = 0
	)

	attribute_stats = list(
		ATTRIBUTE_STRENGTH = 20,
		ATTRIBUTE_DEXTERITY = 10
	)

	attribute_damage = list(
		ATTRIBUTE_STRENGTH = BLUNT,
		ATTRIBUTE_DEXTERITY = BLUNT
	)

	skill_stats = list(
		SKILL_MELEE = 10
	)

	skill_damage = list(
		SKILL_MELEE = BLUNT
	)

	attack_delay = 10
	attack_delay_max = 15