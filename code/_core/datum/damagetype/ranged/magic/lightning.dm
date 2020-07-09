/damagetype/ranged/magic/lightning
	name = "lightning"

	//The base attack damage of the weapon. It's a flat value, unaffected by any skills or attributes.
	attack_damage_base = list(
		HOLY = 40
	)

	attribute_stats = list()

	attribute_damage = list()

	skill_stats = list(
		SKILL_PRAYER = 40,
	)

	skill_damage = list(
		SKILL_PRAYER = HOLY
	)