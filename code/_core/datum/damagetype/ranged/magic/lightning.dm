/damagetype/ranged/magic/lightning
	name = "lightning"

	//The base attack damage of the weapon. It's a flat value, unaffected by any skills or attributes.
	attack_damage_base = list(
		MAGIC = 5,
		HOLY = 15
	)

	//How much armor to penetrate. It basically removes the percentage of the armor using these values.
	attack_damage_penetration = list(
		MAGIC = 25,
		HOLY = 25
	)

	attribute_stats = list(
		ATTRIBUTE_INTELLIGENCE = 25
	)

	attribute_damage = list(
		ATTRIBUTE_INTELLIGENCE = MAGIC
	)

	skill_stats = list(
		SKILL_PRAYER = 50,
		SKILL_MAGIC = 25
	)

	skill_damage = list(
		SKILL_PRAYER = HOLY,
		SKILL_MAGIC = MAGIC
	)