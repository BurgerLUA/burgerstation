/damagetype/ranged/magic/chaos
	name = "chaos ball"

	//The base attack damage of the weapon. It's a flat value, unaffected by any skills or attributes.
	attack_damage_base = list(
		DARK = DAMAGE_AXE*0.5
	)

	attribute_stats = list(
		ATTRIBUTE_INTELLIGENCE = DAMAGE_AXE*0.25
	)

	attribute_damage = list(
		ATTRIBUTE_INTELLIGENCE = DARK
	)

	skill_stats = list(
		SKILL_SORCERY = DAMAGE_AXE*0.25
	)

	skill_damage = list(
		SKILL_SORCERY = DARK
	)

	bonus_experience = list(
		SKILL_SORCERY = 50 //50%
	)