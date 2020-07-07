/damagetype/ranged/magic/magic_missile
	name = "magic missle"

	//The base attack damage of the weapon. It's a flat value, unaffected by any skills or attributes.
	attack_damage_base = list(
		MAGIC = 15
	)

	attribute_stats = list(
		ATTRIBUTE_INTELLIGENCE = 15
	)

	attribute_damage = list(
		ATTRIBUTE_INTELLIGENCE = MAGIC
	)

	skill_stats = list(
		SKILL_MAGIC = 15
	)

	skill_damage = list(
		SKILL_MAGIC = MAGIC
	)