/damagetype/melee/club/null_rod
	name = "null rod"

	attack_damage_base = list(
		BLUNT = 30*0.2,
		HOLY = 0
	)

	attack_damage_penetration = list(
		BLUNT = 20*0.25,
		HOLY = 20*0.75
	)

	attribute_stats = list(
		ATTRIBUTE_STRENGTH = 30*0.2
	)

	attribute_damage = list(
		ATTRIBUTE_STRENGTH = BLUNT
	)

	skill_stats = list(
		SKILL_MELEE = 30*0.1,
		SKILL_PRAYER = 30*0.5
	)

	skill_damage = list(
		SKILL_MELEE = BLUNT,
		SKILL_PRAYER = HOLY
	)

	bonus_experience_skill = list(
		SKILL_MELEE = 25, //25%
		SKILL_PRAYER = 25
	)

	attack_delay = 10*0.5
	attack_delay_max = 10