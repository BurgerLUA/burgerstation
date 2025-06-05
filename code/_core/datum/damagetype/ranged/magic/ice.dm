/damagetype/ranged/magic/ice
	attack_damage_base = list(
		PIERCE = 20,
		COLD = 40
	)

	attribute_stats = list(
		ATTRIBUTE_INTELLIGENCE = 40
	)

	attribute_damage = list(
		ATTRIBUTE_INTELLIGENCE = COLD
	)

	skill_stats = list(
		SKILL_MAGIC = 40
	)

	skill_damage = list(
		SKILL_MAGIC = COLD
	)

	damage_magic_type_consideration = list(
		COLD = ARCANE,
		PIERCE = ARCANE
	)

/damagetype/ranged/magic/fire
	attack_damage_base = list(
		PIERCE = 20,
		HEAT = 40
	)

	attribute_stats = list(
		ATTRIBUTE_INTELLIGENCE = 40
	)

	attribute_damage = list(
		ATTRIBUTE_INTELLIGENCE = HEAT
	)

	skill_stats = list(
		SKILL_MAGIC = 40
	)

	skill_damage = list(
		SKILL_MAGIC = HEAT
	)

	damage_magic_type_consideration = list(
		HEAT = ARCANE,
		PIERCE = ARCANE
	)