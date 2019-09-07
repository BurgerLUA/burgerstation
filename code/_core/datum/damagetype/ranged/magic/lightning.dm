/damagetype/ranged/magic/lightning
	name = "lightning"
	id = "magic_lightning"

	//The base attack damage of the weapon. It's a flat value, unaffected by any skills or attributes.
	attack_damage_base = list(
		PIERCE = 5,
		MAGIC = 5,
		HOLY = 10
	)

	//The damage conversion table of the weapon. Useful for when you want blade attacks to deal holy damage or something.
	attack_damage_conversion = list(
		PIERCE = BRUTE,
		MAGIC = BURN,
		HOLY = BURN,
		DARK = BURN
	)

	//How much armor to penetrate. It basically removes the percentage of the armor using these values.
	attack_damage_penetration = list(
		PIERCE = 100,
		MAGIC = 25,
		HOLY = 50
	)

	attribute_stats = list(
		ATTRIBUTE_VITALITY = CLASS_D,
		ATTRIBUTE_INTELLIGENCE = CLASS_C
	)

	attribute_damage = list(
		ATTRIBUTE_VITALITY = PIERCE,
		ATTRIBUTE_INTELLIGENCE = MAGIC
	)

	skill_stats = list(
		SKILL_PRAYER = CLASS_B,
		SKILL_MAGIC_OFFENSIVE = CLASS_D
	)

	skill_damage = list(
		SKILL_PRAYER = HOLY,
		SKILL_MAGIC_OFFENSIVE = MAGIC
	)

	skill_xp_per_damage = list(
		SKILL_PRAYER = 0.75,
		SKILL_MAGIC_OFFENSIVE = 0.25
	)