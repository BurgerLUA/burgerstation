/damagetype/ranged/magic/crystal
	name = "magic crystal"

	//The base attack damage of the weapon. It's a flat value, unaffected by any skills or attributes.
	attack_damage_base = list(
		ARCANE = 45*0.1,
		DARK = 45*0.2
	)

	attribute_stats = list(
		ATTRIBUTE_INTELLIGENCE = 45*0.3
	)

	attribute_damage = list(
		ATTRIBUTE_INTELLIGENCE = list(ARCANE,DARK)
	)

	skill_stats = list(
		SKILL_SORCERY = 45*0.4
	)

	skill_damage = list(
		SKILL_SORCERY = list(ARCANE,DARK)
	)

	bonus_experience_skill = list(
		SKILL_SORCERY = 75 //75%
	)


/damagetype/ranged/magic/crystal/true
	name = "magic crystal"

	//The base attack damage of the weapon. It's a flat value, unaffected by any skills or attributes.
	attack_damage_base = list(
		ARCANE = 60*0.1,
		DARK = 60*0.2
	)

	attribute_stats = list(
		ATTRIBUTE_INTELLIGENCE = 60*0.3
	)

	attribute_damage = list(
		ATTRIBUTE_INTELLIGENCE = list(ARCANE,DARK)
	)

	skill_stats = list(
		SKILL_SORCERY = 60*0.4
	)

	skill_damage = list(
		SKILL_SORCERY = list(ARCANE,DARK)
	)

	bonus_experience_skill = list(
		SKILL_SORCERY = 75 //75%
	)