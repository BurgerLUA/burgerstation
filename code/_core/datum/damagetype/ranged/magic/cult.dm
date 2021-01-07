/damagetype/ranged/magic/cult
	name = "cult magic"

	attack_damage_base = list(
		DARK = DAMAGE_CLUB*0.25
	)

	attribute_stats = list()

	attribute_damage = list()

	skill_stats = list(
		SKILL_PRAYER = DAMAGE_CLUB*0.75,
	)

	skill_damage = list(
		SKILL_PRAYER = DARK
	)

	bonus_experience = list(
		SKILL_PRAYER = 50 //50%
	)