/damagetype/ranged/magic/fireball
	name = "fire ball"
	id = "magic_fireball"

	//The base attack damage of the weapon. It's a flat value, unaffected by any skills or attributes.
	attack_damage_base = list(
		MAGIC = DAMAGE_E,
		HEAT = DAMAGE_D
	)

	//The damage conversion table of the weapon. Useful for when you want blade attacks to deal holy damage or something.
	attack_damage_conversion = list(
		MAGIC = BURN,
		HEAT = BURN
	)

	//How much armor to penetrate. It basically removes the percentage of the armor using these values.
	attack_damage_penetration = list(
		MAGIC = ARMOR_C,
		HEAT = ARMOR_B
	)

	attribute_stats = list(
		ATTRIBUTE_INTELLIGENCE = CLASS_B
	)

	attribute_damage = list(
		ATTRIBUTE_INTELLIGENCE = MAGIC
	)

	skill_stats = list(
		SKILL_MAGIC_OFFENSIVE = CLASS_B
	)

	skill_damage = list(
		SKILL_MAGIC_OFFENSIVE = MAGIC
	)

	skill_xp_per_damage = list(
		SKILL_MAGIC_OFFENSIVE = SKILL_B
	)