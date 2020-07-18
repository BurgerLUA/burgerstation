/damagetype/melee/club/stunbaton
	name = "inactive stunbaton"

	//The base attack damage of the weapon. It's a flat value, unaffected by any skills or attributes.
	attack_damage_base = list(
		BLUNT = 15
	)

	attribute_stats = list(
		ATTRIBUTE_STRENGTH = 30,
		ATTRIBUTE_DEXTERITY = 10
	)

	attribute_damage = list(
		ATTRIBUTE_STRENGTH = BLUNT,
		ATTRIBUTE_DEXTERITY = BLUNT
	)

	skill_stats = list(
		SKILL_MELEE = 20
	)

	skill_damage = list(
		SKILL_MELEE = BLUNT
	)

/damagetype/melee/club/stunbaton/on
	name = "active stunbaton"

	//The base attack damage of the weapon. It's a flat value, unaffected by any skills or attributes.
	attack_damage_base = list(
		FATIGUE = 40,
		ION = 20
	)

	//How much armor to penetrate. It basically removes the percentage of the armor using these values.
	attack_damage_penetration = list(
		FATIGUE = 50
	)

	attribute_stats = list()

	attribute_damage = list()

	skill_stats = list()

	skill_damage = list()


/damagetype/melee/club/stunbaton/on/harm
	name = "active stunbaton"

	//The base attack damage of the weapon. It's a flat value, unaffected by any skills or attributes.
	attack_damage_base = list(
		BLUNT = 20,
		FATIGUE = 20,
		ION = 20
	)

	attack_damage_penetration = list(
		FATIGUE = 75
	)

	attribute_stats = list(
		ATTRIBUTE_STRENGTH = 30,
		ATTRIBUTE_DEXTERITY = 10
	)

	attribute_damage = list(
		ATTRIBUTE_STRENGTH = BLUNT,
		ATTRIBUTE_DEXTERITY = BLUNT
	)

	skill_stats = list(
		SKILL_MELEE = 20
	)

	skill_damage = list(
		SKILL_MELEE = BLUNT
	)