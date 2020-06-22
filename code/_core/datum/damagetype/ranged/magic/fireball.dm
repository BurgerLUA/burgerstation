/damagetype/ranged/magic/fireball
	name = "fire ball"

	//The base attack damage of the weapon. It's a flat value, unaffected by any skills or attributes.
	attack_damage_base = list(
		MAGIC = 10,
		HEAT = 10
	)

	//How much armor to penetrate. It basically removes the percentage of the armor using these values.
	attack_damage_penetration = list(
		MAGIC = 25,
		HEAT = 25
	)

	attribute_stats = list(
		ATTRIBUTE_INTELLIGENCE = 25
	)

	attribute_damage = list(
		ATTRIBUTE_INTELLIGENCE = list(MAGIC,HEAT)
	)

	skill_stats = list(
		SKILL_MAGIC = 25
	)

	skill_damage = list(
		SKILL_MAGIC = list(MAGIC,HEAT)
	)