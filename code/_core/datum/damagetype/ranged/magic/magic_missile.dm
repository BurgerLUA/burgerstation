/damagetype/ranged/magic/magic_missile
	name = "magic missle"
	id = "magic_missile"

	//The base attack damage of the weapon. It's a flat value, unaffected by any skills or attributes.
	attack_damage_base = list(
		PIERCE = DAMAGE_C,
		MAGIC = DAMAGE_B
	)

	//How much armor to penetrate. It basically removes the percentage of the armor using these values.
	attack_damage_penetration = list(
		PIERCE = ARMOR_C,
		MAGIC = ARMOR_C
	)

	attribute_stats = list(
		ATTRIBUTE_INTELLIGENCE = CLASS_C
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
		SKILL_MAGIC_OFFENSIVE = 1
	)