/damagetype/ranged/magic/magefire/
	name = "fire"

	//The base attack damage of the weapon. It's a flat value, unaffected by any skills or attributes.
	attack_damage_base = list(
		HEAT = 10,
		ARCANE = 10
	)

	attribute_stats = list(
		ATTRIBUTE_INTELLIGENCE = 20
	)

	attribute_damage = list(
		ATTRIBUTE_INTELLIGENCE = list(HEAT,ARCANE)
	)

	skill_stats = list(
		SKILL_SORCERY = 20,
	)

	skill_damage = list(
		SKILL_SORCERY = list(HEAT,ARCANE)
	)

	bonus_experience = list(
		SKILL_SORCERY = 50
	)