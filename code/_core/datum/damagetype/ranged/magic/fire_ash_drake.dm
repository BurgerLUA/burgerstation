/damagetype/ranged/magic/fire/ash_drake
	name = "ash drake's true fire breath"
	id = "ash_drake_fire"

	//The base attack damage of the weapon. It's a flat value, unaffected by any skills or attributes.
	attack_damage_base = list(
		HEAT = DAMAGE_B
	)

	//How much armor to penetrate. It basically removes the percentage of the armor using these values.
	attack_damage_penetration = list(
		HEAT = ARMOR_B
	)

	attribute_stats = list(
		ATTRIBUTE_INTELLIGENCE = CLASS_C
	)

	attribute_damage = list(
		ATTRIBUTE_INTELLIGENCE = HEAT
	)

	skill_stats = list(
		SKILL_MAGIC_OFFENSIVE = CLASS_C,
	)

	skill_damage = list(
		SKILL_MAGIC_OFFENSIVE = HEAT
	)

	skill_xp_per_damage = list(
		SKILL_MAGIC_OFFENSIVE = SKILL_C
	)