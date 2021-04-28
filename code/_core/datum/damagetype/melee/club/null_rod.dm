/damagetype/melee/club/null_rod
	name = "null rod"

	attack_damage_base = list(
		BLUNT = 10,
		HOLY = 0
	)

	attack_damage_penetration = list(
		BLUNT = 10,
		HOLY = 50
	)

	attribute_stats = list(
		ATTRIBUTE_STRENGTH = 20
	)

	attribute_damage = list(
		ATTRIBUTE_STRENGTH = BLUNT
	)

	skill_stats = list(
		SKILL_MELEE = 20,
		SKILL_PRAYER = 80
	)

	skill_damage = list(
		SKILL_MELEE = BLUNT,
		SKILL_PRAYER = HOLY
	)

	bonus_experience_skill = list(
		SKILL_MELEE = 25, //25%
		SKILL_PRAYER = 25
	)

	attack_delay = 8
	attack_delay_max = 12