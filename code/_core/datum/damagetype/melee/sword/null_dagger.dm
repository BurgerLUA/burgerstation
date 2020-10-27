/damagetype/melee/sword/null_dagger
	name = "null dagger"

	attack_damage_base = list(
		BLADE = DAMAGE_DAGGER*0.1,
		PIERCE = DAMAGE_DAGGER*0.1,
		HOLY = 0
	)

	attack_damage_penetration = list(
		BLADE = AP_DAGGER*0.5,
		HOLY = AP_DAGGER*0.5
	)

	attribute_stats = list(
		ATTRIBUTE_DEXTERITY = DAMAGE_DAGGER*0.2
	)

	attribute_damage = list(
		ATTRIBUTE_DEXTERITY = list(BLADE,PIERCE)
	)

	skill_stats = list(
		SKILL_MELEE = DAMAGE_DAGGER*0.1,
		SKILL_PRAYER = DAMAGE_DAGGER*0.5
	)

	skill_damage = list(
		SKILL_MELEE = list(BLADE,PIERCE),
		SKILL_PRAYER = HOLY
	)

	attack_delay = SPEED_DAGGER*0.5
	attack_delay_max = SPEED_DAGGER