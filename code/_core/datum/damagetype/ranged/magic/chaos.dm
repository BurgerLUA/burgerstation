/damagetype/ranged/magic/chaos
	name = "chaos ball"
	id = "magic_chaosball"

	//The base attack damage of the weapon. It's a flat value, unaffected by any skills or attributes.
	attack_damage_base = list(
		MAGIC = DAMAGE_D,
		DARK = DAMAGE_C
	)

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
		SKILL_MAGIC_CHAOS = SKILL_B,
		SKILL_MAGIC_OFFENSIVE = SKILL_C
	)