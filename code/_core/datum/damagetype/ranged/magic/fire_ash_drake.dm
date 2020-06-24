/damagetype/ranged/magic/fire/ash_drake
	name = "fire"

	//The base attack damage of the weapon. It's a flat value, unaffected by any skills or attributes.
	attack_damage_base = list(
		HEAT = 20,
		MAGIC = 20
	)

	attribute_stats = list(
		ATTRIBUTE_INTELLIGENCE = 40
	)

	attack_damage_penetration = list(
		HEAT = INFINITY,
		MAGIC = INFINITY
	)

	attribute_damage = list(
		ATTRIBUTE_INTELLIGENCE = list(MAGIC,HEAT)
	)

	skill_stats = list(
		SKILL_MAGIC = 40,
	)

	skill_damage = list(
		SKILL_MAGIC = list(MAGIC,HEAT)
	)