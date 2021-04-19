/damagetype/melee/club/null_staff
	name = "null staff"

	attack_damage_base = list(
		BLUNT = 45*0.2,
		HOLY = 0
	)

	attack_damage_penetration = list(
		BLUNT = 40*0.25,
		HOLY = 40*0.75
	)

	attribute_stats = list(
		ATTRIBUTE_STRENGTH = 45*0.1,
		ATTRIBUTE_DEXTERITY = 45*0.2
	)

	attribute_damage = list(
		ATTRIBUTE_STRENGTH = BLUNT
	)

	skill_stats = list(
		SKILL_MELEE = 45*0.1,
		SKILL_PRAYER = 45*0.40
	)

	skill_damage = list(
		SKILL_MELEE = BLUNT,
		SKILL_PRAYER = HOLY
	)

	bonus_experience_skill = list(
		SKILL_MELEE = 25, //25%
		SKILL_PRAYER = 25
	)

	attack_delay = 12*0.5
	attack_delay_max = 12