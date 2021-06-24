/damagetype/melee/sword/crystal
	name = "conjuring crystals"

	//The base attack damage of the weapon. It's a flat value, unaffected by any skills or attributes.
	attack_damage_base = list(
		BLUNT = 20,
		ARCANE = 5
	)

	//How much armor to penetrate. It basically removes the percentage of the armor using these values.
	attack_damage_penetration = list(
		BLUNT = 0,
		ARCANE = 25
	)

	attribute_stats = list(
		ATTRIBUTE_STRENGTH = 20,
		ATTRIBUTE_INTELLIGENCE = 30
	)

	attribute_damage = list(
		ATTRIBUTE_STRENGTH = BLUNT,
		ATTRIBUTE_INTELLIGENCE = ARCANE
	)

	skill_stats = list(
		SKILL_MELEE = 10,
		SKILL_MAGIC_DEFENSIVE = 50
	)

	skill_damage = list(
		SKILL_MELEE = BLADE,
		SKILL_MAGIC_DEFENSIVE = ARCANE
	)

	attack_delay = 10
	attack_delay_max = 15

/damagetype/melee/sword/crystal/rapier
	name = "crystal rapier"

	//The base attack damage of the weapon. It's a flat value, unaffected by any skills or attributes.
	attack_damage_base = list(
		PIERCE = 10,
		ARCANE = 5
	)

	//How much armor to penetrate. It basically removes the percentage of the armor using these values.
	attack_damage_penetration = list(
		PIERCE = 75,
		ARCANE = 75
	)

	attribute_stats = list(
		ATTRIBUTE_DEXTERITY = 20,
		ATTRIBUTE_INTELLIGENCE = 15
	)

	attribute_damage = list(
		ATTRIBUTE_DEXTERITY = PIERCE,
		ATTRIBUTE_INTELLIGENCE = ARCANE
	)

	skill_stats = list(
		SKILL_MELEE = 30,
		SKILL_MAGIC_DEFENSIVE = 30
	)

	skill_damage = list(
		SKILL_MELEE = PIERCE,
		SKILL_MAGIC_DEFENSIVE = ARCANE
	)

	attack_delay = 5
	attack_delay_max = 10

/damagetype/melee/sword/crystal/longsword
	name = "crystal longsword"

	//The base attack damage of the weapon. It's a flat value, unaffected by any skills or attributes.
	attack_damage_base = list(
		BLADE = 20,
		ARCANE = 10
	)

	//How much armor to penetrate. It basically removes the percentage of the armor using these values.
	attack_damage_penetration = list(
		BLADE = 50,
		ARCANE = 25
	)

	attribute_stats = list(
		ATTRIBUTE_STRENGTH = 40,
		ATTRIBUTE_INTELLIGENCE = 20
	)

	attribute_damage = list(
		ATTRIBUTE_STRENGTH = BLADE,
		ATTRIBUTE_INTELLIGENCE = ARCANE
	)

	skill_stats = list(
		SKILL_MELEE = 10,
		SKILL_MAGIC_DEFENSIVE = 30
	)

	skill_damage = list(
		SKILL_MELEE = BLADE,
		SKILL_MAGIC_DEFENSIVE = ARCANE
	)

	attack_delay = 15
	attack_delay_max = 20