/damagetype/ranged/magic/lightning
	name = "lightning"

	//The base attack damage of the weapon. It's a flat value, unaffected by any skills or attributes.
	attack_damage_base = list(
		HOLY = DAMAGE_CLUB*0.25
	)

	attribute_stats = list()

	attribute_damage = list()

	skill_stats = list(
		SKILL_PRAYER = DAMAGE_CLUB*0.75,
	)

	skill_damage = list(
		SKILL_PRAYER = HOLY
	)

	bonus_experience = list(
		SKILL_PRAYER = 50 //50%
	)