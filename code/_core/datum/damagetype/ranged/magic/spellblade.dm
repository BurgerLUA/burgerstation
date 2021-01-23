/damagetype/ranged/magic/spellblade
	name = "spellblade"

	//The base attack damage of the weapon. It's a flat value, unaffected by any skills or attributes.
	attack_damage_base = list(
		BLADE = DAMAGE_GREATSWORD*0.25,
		ARCANE = DAMAGE_GREATSWORD*0.15
	)

	attribute_stats = list(
		ATTRIBUTE_STRENGTH = DAMAGE_GREATSWORD*0.15,
		ATTRIBUTE_INTELLIGENCE = DAMAGE_GREATSWORD*0.15
	)

	attribute_damage = list(
		ATTRIBUTE_STRENGTH = BLADE,
		ATTRIBUTE_INTELLIGENCE = ARCANE
	)

	skill_stats = list(
		SKILL_MELEE = DAMAGE_GREATSWORD*0.15,
		SKILL_SORCERY =  DAMAGE_GREATSWORD*0.15
	)

	skill_damage = list(
		SKILL_MELEE = BLADE,
		SKILL_SORCERY = ARCANE
	)

	bonus_experience = list(
		SKILL_SORCERY = 25, //25%
		SKILL_MELEE = 25
	)

	attack_delay = SPEED_GREATSWORD*0.5
	attack_delay_max = SPEED_GREATSWORD