/damagetype/ranged/magic/flame
	name = "flame"

	//The base attack damage of the weapon. It's a flat value, unaffected by any skills or attributes.
	attack_damage_base = list(
		FIRE = 45*0.4,
		ARCANE = 45*0.1
	)

	attribute_stats = list(
		ATTRIBUTE_INTELLIGENCE = 45*0.2
	)

	attribute_damage = list(
		ATTRIBUTE_INTELLIGENCE = list(FIRE,ARCANE)
	)

	skill_stats = list(
		SKILL_SORCERY = 45*0.3,
	)

	skill_damage = list(
		SKILL_SORCERY = ARCANE
	)

	bonus_experience_skill = list(
		SKILL_SORCERY = 75 //75%
	)