/damagetype/default/
	name = "default"

	//The base attack damage of the weapon. It's a flat value, unaffected by any skills or attributes.
	attack_damage_base = list(
		BLUNT = 10,
	)

	//How much armor to penetrate. It basically removes the percentage of the armor using these values.
	attack_damage_penetration = list(
		BLUNT = 0
	)

	attribute_stats = list(
		ATTRIBUTE_STRENGTH = 0.2
	)

	attribute_damage = list(
		ATTRIBUTE_STRENGTH = BLUNT,
	)

	skill_stats = list(
		SKILL_MELEE = 0.1,
	)

	skill_damage = list(
		SKILL_MELEE = BLUNT
	)