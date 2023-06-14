/damagetype/ranged/magic/tesla
	attack_damage_base = list(
		SHOCK = 60
	)

	attribute_stats = list(
		ATTRIBUTE_INTELLIGENCE = 30
	)

	attribute_damage = list(
		ATTRIBUTE_INTELLIGENCE = list(SHOCK)
	)

	skill_stats = list(
		SKILL_MAGIC = 30,
	)

	skill_damage = list(
		SKILL_MAGIC = SHOCK
	)

/damagetype/ranged/magic/tesla_shock

	//The base attack damage of the weapon. It's a flat value, unaffected by any skills or attributes.
	attack_damage_base = list(
		SHOCK = 10
	)

	attribute_stats = list(
		ATTRIBUTE_INTELLIGENCE = 20
	)

	attribute_damage = list(
		ATTRIBUTE_INTELLIGENCE = list(SHOCK)
	)

	skill_stats = list(
		SKILL_MAGIC = 20,
	)

	skill_damage = list(
		SKILL_MAGIC = SHOCK
	)