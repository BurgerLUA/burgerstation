/damagetype/ranged/magic/fire/
	name = "fire breath"
	id = "fire"

	//The base attack damage of the weapon. It's a flat value, unaffected by any skills or attributes.
	attack_damage_base = list(
		HEAT = 10
	)

	//The damage conversion table of the weapon. Useful for when you want blade attacks to deal holy damage or something.
	attack_damage_conversion = list(
		HEAT = BURN
	)

	//How much armor to penetrate. It basically removes the percentage of the armor using these values.
	attack_damage_penetration = list(
		HEAT = 25
	)

	attribute_stats = list(
		ATTRIBUTE_INTELLIGENCE = CLASS_D
	)

	attribute_damage = list(
		ATTRIBUTE_INTELLIGENCE = HEAT
	)

	skill_stats = list(
		SKILL_MAGIC_OFFENSIVE = CLASS_D,
	)

	skill_damage = list(
		SKILL_MAGIC_OFFENSIVE = HEAT
	)

	skill_xp_per_damage = list(
		SKILL_MAGIC_OFFENSIVE = 1
	)