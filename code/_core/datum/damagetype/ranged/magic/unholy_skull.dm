/damagetype/ranged/magic/unholy_skull
	name = "unholy skull"

	//The base attack damage of the weapon. It's a flat value, unaffected by any skills or attributes.
	attack_damage_base = list(
		BLUNT = 60*0.1,
		DARK = 60*0.15
	)

	attribute_stats = list()

	attribute_damage = list()

	skill_stats = list(
		SKILL_PRAYER = 60*0.75,
	)

	skill_damage = list(
		SKILL_PRAYER = list(BLUNT,DARK)
	)

	bonus_experience_skill = list(
		SKILL_PRAYER = 75 //75%
	)