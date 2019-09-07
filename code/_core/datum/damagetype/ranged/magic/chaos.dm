/damagetype/ranged/magic/chaos
	name = "chaos ball"
	id = "magic_chaosball"

	//The base attack damage of the weapon. It's a flat value, unaffected by any skills or attributes.
	attack_damage_base = list(
		MAGIC = 5,
		DARK = 10
	)

	//The damage conversion table of the weapon. Useful for when you want blade attacks to deal holy damage or something.
	attack_damage_conversion = list(
		MAGIC = BURN,
		DARK = BURN
	)

	//How much armor to penetrate. It basically removes the percentage of the armor using these values.
	attack_damage_penetration = list()

	attribute_stats = list(
		ATTRIBUTE_INTELLIGENCE = CLASS_C
	)

	attribute_damage = list(
		ATTRIBUTE_INTELLIGENCE = MAGIC
	)

	skill_stats = list(
		SKILL_MAGIC_CHAOS = CLASS_C,
		SKILL_MAGIC_OFFENSIVE = CLASS_D
	)

	skill_damage = list(
		SKILL_MAGIC_CHAOS = DARK,
		SKILL_MAGIC_OFFENSIVE = MAGIC
	)

	skill_xp_per_damage = list(
		SKILL_MAGIC_CHAOS = 0.75,
		SKILL_MAGIC_OFFENSIVE = 0.25
	)