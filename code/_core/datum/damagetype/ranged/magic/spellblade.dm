/damagetype/ranged/magic/spellblade
	name = "spellblade"

	//The base attack damage of the weapon. It's a flat value, unaffected by any skills or attributes.
	attack_damage_base = list(
		BLADE = 75*0.25,
		ARCANE = 75*0.15
	)

	attribute_stats = list(
		ATTRIBUTE_STRENGTH = 75*0.15,
		ATTRIBUTE_INTELLIGENCE = 75*0.15
	)

	attribute_damage = list(
		ATTRIBUTE_STRENGTH = BLADE,
		ATTRIBUTE_INTELLIGENCE = ARCANE
	)

	skill_stats = list(
		SKILL_MELEE = 75*0.15,
		SKILL_SORCERY =  75*0.15
	)

	skill_damage = list(
		SKILL_MELEE = BLADE,
		SKILL_SORCERY = ARCANE
	)

	bonus_experience_skill = list(
		SKILL_SORCERY = 25, //25%
		SKILL_MELEE = 25
	)

	attack_delay = 16*0.5
	attack_delay_max = 16