/damagetype/ranged/magic/ice
	name = "ice shard"

	//The base attack damage of the weapon. It's a flat value, unaffected by any skills or attributes.
	attack_damage_base = list(
		PIERCE = 5,
		COLD = 10
	)

	attribute_stats = list(
		ATTRIBUTE_INTELLIGENCE = 15
	)

	attribute_damage = list(
		ATTRIBUTE_INTELLIGENCE = list(PIERCE,COLD)
	)

	skill_stats = list(
		SKILL_SORCERY = 15
	)

	skill_damage = list(
		SKILL_SORCERY = list(PIERCE,COLD)
	)