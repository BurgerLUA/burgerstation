/damagetype/ranged/magic/chaos
	name = "chaos ball"

	//The base attack damage of the weapon. It's a flat value, unaffected by any skills or attributes.
	attack_damage_base = list(
		DARK = DAMAGE_SWORD*0.5
	)

	attribute_stats = list(
		ATTRIBUTE_INTELLIGENCE = DAMAGE_SWORD*0.25
	)

	attribute_damage = list(
		ATTRIBUTE_INTELLIGENCE = DARK
	)

	skill_stats = list(
		SKILL_SORCERY = DAMAGE_SWORD*0.25
	)

	skill_damage = list(
		SKILL_SORCERY = DARK
	)