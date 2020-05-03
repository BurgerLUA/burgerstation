/damagetype/ranged/magic/magic_missile
	name = "magic missle"

	//The base attack damage of the weapon. It's a flat value, unaffected by any skills or attributes.
	attack_damage_base = list(
		MAGIC = 20
	)

	//How much armor to penetrate. It basically removes the percentage of the armor using these values.
	attack_damage_penetration = list(
		MAGIC = 75
	)

	attribute_stats = list(
		ATTRIBUTE_INTELLIGENCE = 60
	)

	attribute_damage = list(
		ATTRIBUTE_INTELLIGENCE = MAGIC
	)

	skill_stats = list(
		SKILL_MAGIC = 50
	)

	skill_damage = list(
		SKILL_MAGIC = MAGIC
	)