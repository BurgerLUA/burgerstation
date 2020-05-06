/damagetype/ranged/magic/fire/
	name = "fire"

	//The base attack damage of the weapon. It's a flat value, unaffected by any skills or attributes.
	attack_damage_base = list(
		HEAT = 10
	)

	//How much armor to penetrate. It basically removes the percentage of the armor using these values.
	attack_damage_penetration = list(
		HEAT = 0
	)

	attribute_stats = list(
		ATTRIBUTE_INTELLIGENCE = 50
	)

	attribute_damage = list(
		ATTRIBUTE_INTELLIGENCE = HEAT
	)

	skill_stats = list(
		SKILL_MAGIC = 50,
	)

	skill_damage = list(
		SKILL_MAGIC = HEAT
	)