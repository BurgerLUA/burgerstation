/damagetype/melee/club/stunbaton
	name = "inactive stunbaton"

	//The base attack damage of the weapon. It's a flat value, unaffected by any skills or attributes.
	attack_damage_base = list(
		BLUNT = 60*0.2
	)

	attribute_stats = list(
		ATTRIBUTE_STRENGTH = 60*0.5,
		ATTRIBUTE_DEXTERITY = 60*0.1
	)

	attribute_damage = list(
		ATTRIBUTE_STRENGTH = BLUNT,
		ATTRIBUTE_DEXTERITY = BLUNT
	)

	skill_stats = list(
		SKILL_MELEE = 60*0.2
	)

	skill_damage = list(
		SKILL_MELEE = BLUNT
	)

	attack_delay = 14*0.5
	attack_delay_max = 14

/damagetype/melee/club/stunbaton/on
	name = "active stunbaton"

	//The base attack damage of the weapon. It's a flat value, unaffected by any skills or attributes.
	attack_damage_base = list(
		FATIGUE = 60*0.8,
		ION = 60*0.2
	)

	//How much armor to penetrate. It basically removes the percentage of the armor using these values.
	attack_damage_penetration = list(
		FATIGUE = 60
	)

	attribute_stats = list()

	attribute_damage = list()

	skill_stats = list()

	skill_damage = list()

	attack_delay = 14*0.5
	attack_delay_max = 14


/damagetype/melee/club/stunbaton/on/harm
	name = "active stunbaton"

	//The base attack damage of the weapon. It's a flat value, unaffected by any skills or attributes.
	attack_damage_base = list(
		BLUNT = 60*0.1,
		FATIGUE = 60*0.3,
		ION = 60*0.1
	)

	attack_damage_penetration = list(
		FATIGUE = 60
	)

	attribute_stats = list(
		ATTRIBUTE_STRENGTH = 60*0.3,
		ATTRIBUTE_DEXTERITY = 60*0.1
	)

	attribute_damage = list(
		ATTRIBUTE_STRENGTH = BLUNT,
		ATTRIBUTE_DEXTERITY = BLUNT
	)

	skill_stats = list(
		SKILL_MELEE = 60*0.1
	)

	skill_damage = list(
		SKILL_MELEE = BLUNT
	)

	attack_delay = 14*0.5
	attack_delay_max = 14