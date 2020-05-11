/damagetype/melee/sword/null_dagger
	name = "null dagger"

	attack_damage_base = list(
		BLADE = 20,
		PIERCE = 20,
		HOLY = 10
	)

	attack_damage_penetration = list(
		BLADE = 10,
		HOLY = 25
	)

	attribute_stats = list(
		ATTRIBUTE_DEXTERITY = 20
	)

	attribute_damage = list(
		ATTRIBUTE_DEXTERITY = list(BLADE,PIERCE)
	)

	skill_stats = list(
		SKILL_MELEE = 20,
		SKILL_PRAYER = 50
	)

	skill_damage = list(
		SKILL_MELEE = list(BLADE,PIERCE),
		SKILL_PRAYER = HOLY
	)