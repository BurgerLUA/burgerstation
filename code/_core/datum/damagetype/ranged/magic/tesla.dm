/damagetype/ranged/magic/tesla
	attack_damage_base = list(
		SHOCK = 60*0.25
	)

	attribute_stats = list(
		ATTRIBUTE_INTELLIGENCE = 60*0.2
	)

	attribute_damage = list(
		ATTRIBUTE_INTELLIGENCE = list(SHOCK)
	)

	skill_stats = list(
		SKILL_MAGIC_OFFENSIVE = 60*0.55,
	)

	skill_damage = list(
		SKILL_MAGIC_OFFENSIVE = SHOCK
	)

	bonus_experience_skill = list(
		SKILL_MAGIC_OFFENSIVE = 75 //75%
	)

/damagetype/ranged/magic/tesla_shock
	name = "tesla shock"

	//The base attack damage of the weapon. It's a flat value, unaffected by any skills or attributes.
	attack_damage_base = list(
		SHOCK = 20*0.25
	)

	attribute_stats = list(
		ATTRIBUTE_INTELLIGENCE = 20*0.2
	)

	attribute_damage = list(
		ATTRIBUTE_INTELLIGENCE = list(SHOCK)
	)

	skill_stats = list(
		SKILL_MAGIC_OFFENSIVE = 20*0.55,
	)

	skill_damage = list(
		SKILL_MAGIC_OFFENSIVE = SHOCK
	)

	bonus_experience_skill = list(
		SKILL_MAGIC_OFFENSIVE = 75 //75%
	)