/damagetype/ranged/magic/chaos
	name = "chaos ball"

	//The base attack damage of the weapon. It's a flat value, unaffected by any skills or attributes.
	attack_damage_base = list(
		MAGIC = 5,
		DARK = 5
	)

	attribute_stats = list(
		ATTRIBUTE_INTELLIGENCE = 25
	)

	attribute_damage = list(
		ATTRIBUTE_INTELLIGENCE = MAGIC
	)

	skill_stats = list(
		SKILL_SORCERY = 25
	)

	skill_damage = list(
		SKILL_SORCERY = DARK
	)