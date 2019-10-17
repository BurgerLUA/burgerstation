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
		SKILL_SORCERY = CLASS_C,
		SKILL_MAGIC = CLASS_D
	)

	skill_damage = list(
		SKILL_SORCERY = DARK,
		SKILL_MAGIC = MAGIC
	)

	skill_xp_per_damage = list(
		SKILL_SORCERY = SKILL_B,
		SKILL_MAGIC = SKILL_C
	)