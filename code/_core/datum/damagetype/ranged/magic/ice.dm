/damagetype/ranged/magic/ice
	name = "ice shard"

	//The base attack damage of the weapon. It's a flat value, unaffected by any skills or attributes.
	attack_damage_base = list(
		PIERCE = DAMAGE_CLUB*0.2,
		COLD = DAMAGE_CLUB*0.3
	)

	attribute_stats = list(
		ATTRIBUTE_INTELLIGENCE = DAMAGE_CLUB*0.25
	)

	attribute_damage = list(
		ATTRIBUTE_INTELLIGENCE = COLD
	)

	skill_stats = list(
		SKILL_SORCERY = DAMAGE_CLUB*0.25
	)

	skill_damage = list(
		SKILL_SORCERY = COLD
	)

	bonus_experience = list(
		SKILL_SORCERY = 50 //50%
	)