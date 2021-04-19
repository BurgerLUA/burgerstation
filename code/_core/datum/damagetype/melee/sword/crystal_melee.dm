/damagetype/melee/sword/crystal
	name = "conjuring crystals"

	//The base attack damage of the weapon. It's a flat value, unaffected by any skills or attributes.
	attack_damage_base = list(
		BLUNT = 15*0.1,
		FATIGUE = 15*0.5
	)

	//How much armor to penetrate. It basically removes the percentage of the armor using these values.
	attack_damage_penetration = list(
		BLUNT = 10*0.25,
		FATIGUE = 10*0.75
	)

	attribute_stats = list(
		ATTRIBUTE_STRENGTH = 15*0.3
	)

	attribute_damage = list(
		ATTRIBUTE_STRENGTH = BLADE
	)

	skill_stats = list(
		SKILL_MELEE = 15*0.1,
	)

	skill_damage = list(
		SKILL_MELEE = BLADE
	)

	attack_delay = 10*0.5
	attack_delay_max = 10

/damagetype/melee/sword/crystal/rapier
	name = "crystal rapier"

	//The base attack damage of the weapon. It's a flat value, unaffected by any skills or attributes.
	attack_damage_base = list(
		PIERCE = 30*0.2,
		ARCANE = 30*0.3
	)

	//How much armor to penetrate. It basically removes the percentage of the armor using these values.
	attack_damage_penetration = list(
		PIERCE = 20*0.6,
		ARCANE = 20*0.4
	)

	attribute_stats = list(
		ATTRIBUTE_DEXTERITY = 30*0.2,
		ATTRIBUTE_INTELLIGENCE = 30*0.2
	)

	attribute_damage = list(
		ATTRIBUTE_DEXTERITY = PIERCE,
		ATTRIBUTE_INTELLIGENCE = ARCANE
	)

	skill_stats = list(
		SKILL_MAGIC = 30*0.2
	)

	skill_damage = list(
		SKILL_MAGIC = ARCANE
	)

	attack_delay = 10*0.5
	attack_delay_max = 12

/damagetype/melee/sword/crystal/longsword
	name = "crystal longsword"

	//The base attack damage of the weapon. It's a flat value, unaffected by any skills or attributes.
	attack_damage_base = list(
		PIERCE = 45*0.2,
		ARCANE = 60*0.3
	)

	//How much armor to penetrate. It basically removes the percentage of the armor using these values.
	attack_damage_penetration = list(
		PIERCE = 20*0.4,
		ARCANE = 20*0.6
	)

	attribute_stats = list(
		ATTRIBUTE_STRENGTH = 30*0.2,
		ATTRIBUTE_INTELLIGENCE = 60*0.2
	)

	attribute_damage = list(
		ATTRIBUTE_STRENGTH = list(BLADE,PIERCE),
		ATTRIBUTE_INTELLIGENCE = ARCANE
	)

	skill_stats = list(
		SKILL_MELEE = 45*0.2,
		SKILL_MAGIC = 60*0.2
	)

	skill_damage = list(
		SKILL_MAGIC = ARCANE
	)

	attack_delay = 10*0.5
	attack_delay_max = 10