/damagetype/ranged/magic/fractal
	attack_damage_base = list(
		BLADE = 30,
		HEAT = 20,
		ARCANE = 10
	)

	attribute_stats = list(
		ATTRIBUTE_INTELLIGENCE = 30
	)

	attribute_damage = list(
		ATTRIBUTE_INTELLIGENCE = list(HEAT,BLADE,ARCANE)
	)

	skill_stats = list(
		SKILL_MAGIC = 30,
	)

	skill_damage = list(
		SKILL_MAGIC = list(HEAT,BLADE,ARCANE)
	)

	damage_magic_type_consideration = list(
		BLADE = ARCANE,
		HEAT = ARCANE,
		ARCANE = ARCANE
	)