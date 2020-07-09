/damagetype/ranged/magic/crystal
	name = "magic crystal"

	//The base attack damage of the weapon. It's a flat value, unaffected by any skills or attributes.
	attack_damage_base = list(
		MAGIC = 10,
		DARK = 10
	)

	attribute_stats = list(
		ATTRIBUTE_INTELLIGENCE = 20
	)

	attribute_damage = list(
		ATTRIBUTE_INTELLIGENCE = list(MAGIC,DARK)
	)

	skill_stats = list(
		SKILL_SORCERY = 20
	)

	skill_damage = list(
		SKILL_SORCERY = list(MAGIC,DARK)
	)