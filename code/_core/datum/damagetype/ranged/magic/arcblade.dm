/damagetype/ranged/magic/arcblade
	attack_damage_base = list(
		BLADE = 40*0.4,
		ARCANE = 40*0.1
	)

	attribute_stats = list(
		ATTRIBUTE_INTELLIGENCE = 40*0.2
	)

	attribute_damage = list(
		ATTRIBUTE_INTELLIGENCE = list(BLADE,ARCANE)
	)

	skill_stats = list(
		SKILL_MAGIC_OFFENSIVE = 40*0.3,
	)

	skill_damage = list(
		SKILL_MAGIC_OFFENSIVE = ARCANE
	)

	bonus_experience_skill = list(
		SKILL_MAGIC_OFFENSIVE = 75 //75%
	)