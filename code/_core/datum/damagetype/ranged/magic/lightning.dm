/damagetype/ranged/magic/lightning
	name = "lightning"
	id = "magic_lightning"

	//The base attack damage of the weapon. It's a flat value, unaffected by any skills or attributes.
	attack_damage_base = list(
		PIERCE = DAMAGE_D,
		MAGIC = DAMAGE_C,
		HOLY = DAMAGE_C
	)

	//The damage conversion table of the weapon. Useful for when you want blade attacks to deal holy damage or something.
	attack_damage_conversion = list(
		PIERCE = BRUTE,
		MAGIC = BURN,
		HOLY = BURN
	)

	//How much armor to penetrate. It basically removes the percentage of the armor using these values.
	attack_damage_penetration = list(
		PIERCE = ARMOR_B,
		MAGIC = ARMOR_B,
		HOLY = ARMOR_B
	)

	attribute_stats = list(
		ATTRIBUTE_INTELLIGENCE = CLASS_C
	)

	attribute_damage = list(
		ATTRIBUTE_INTELLIGENCE = MAGIC
	)

	skill_stats = list(
		SKILL_PRAYER = CLASS_A,
		SKILL_MAGIC_OFFENSIVE = CLASS_D
	)

	skill_damage = list(
		SKILL_PRAYER = HOLY,
		SKILL_MAGIC_OFFENSIVE = MAGIC
	)

	skill_xp_per_damage = list(
		SKILL_PRAYER = SKILL_A,
		SKILL_MAGIC_OFFENSIVE = SKILL_D
	)