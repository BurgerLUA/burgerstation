/damagetype/melee/sword/null_dagger
	name = "null dagger"

	attack_damage_base = list(
		BLADE = 15*0.1,
		PIERCE = 15*0.1,
		HOLY = 0
	)

	attack_damage_penetration = list(
		BLADE = 10*0.5,
		HOLY = 10*0.5
	)

	attribute_stats = list(
		ATTRIBUTE_DEXTERITY = 15*0.2
	)

	attribute_damage = list(
		ATTRIBUTE_DEXTERITY = list(BLADE,PIERCE)
	)

	skill_stats = list(
		SKILL_MELEE = 15*0.1,
		SKILL_PRAYER = 15*0.5
	)

	skill_damage = list(
		SKILL_MELEE = list(BLADE,PIERCE),
		SKILL_PRAYER = HOLY
	)

	bonus_experience_skill = list(
		SKILL_MELEE = 25, //25%
		SKILL_PRAYER = 25
	)

	attack_delay = 8*0.5
	attack_delay_max = 8