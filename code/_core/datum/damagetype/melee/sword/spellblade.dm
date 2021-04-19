/damagetype/melee/sword/spellblade
	name = "spellblade"

	//The base attack damage of the weapon. It's a flat value, unaffected by any skills or attributes.
	attack_damage_base = list(
		BLADE = 75*0.1,
		PIERCE = 75*0.05,
		ARCANE = 75*0.2
	)

	//How much armor to penetrate. It basically removes the percentage of the armor using these values.
	attack_damage_penetration = list(
		BLADE = 80*0.25,
		PIERCE = 80*0.5,
		ARCANE = 80*0.25
	)

	attribute_stats = list(
		ATTRIBUTE_STRENGTH = 80*0.25
	)

	attribute_damage = list(
		ATTRIBUTE_STRENGTH = list(BLADE,PIERCE)
	)

	skill_stats = list(
		SKILL_MELEE = 75*0.3,
		SKILL_SORCERY = 75*0.35
	)

	skill_damage = list(
		SKILL_MELEE = list(BLADE,PIERCE),
		SKILL_SORCERY = ARCANE
	)

	bonus_experience_skill = list(
		SKILL_MELEE = 25, //25%
		SKILL_SORCERY = 25
	)