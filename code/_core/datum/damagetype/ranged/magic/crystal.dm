/damagetype/ranged/magic/crystal
	name = "magic crystal"

	//The base attack damage of the weapon. It's a flat value, unaffected by any skills or attributes.
	attack_damage_base = list(
		ARCANE = DAMAGE_DAGGER*0.1,
		DARK = DAMAGE_DAGGER*0.2
	)

	attribute_stats = list(
		ATTRIBUTE_INTELLIGENCE = DAMAGE_DAGGER*0.3
	)

	attribute_damage = list(
		ATTRIBUTE_INTELLIGENCE = list(ARCANE,DARK)
	)

	skill_stats = list(
		SKILL_SORCERY = DAMAGE_DAGGER*0.4
	)

	skill_damage = list(
		SKILL_SORCERY = list(ARCANE,DARK)
	)

	bonus_experience = list(
		SKILL_SORCERY = 50 //50%
	)