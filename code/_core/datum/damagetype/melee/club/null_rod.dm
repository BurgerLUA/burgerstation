/damagetype/melee/club/null_rod
	name = "null rod"

	attack_damage_base = list(
		BLUNT = DAMAGE_SWORD*0.2,
		HOLY = 0
	)

	attack_damage_penetration = list(
		BLUNT = AP_SWORD*0.25,
		HOLY = AP_SWORD*0.75
	)

	attribute_stats = list(
		ATTRIBUTE_STRENGTH = DAMAGE_SWORD*0.2
	)

	attribute_damage = list(
		ATTRIBUTE_STRENGTH = BLUNT
	)

	skill_stats = list(
		SKILL_MELEE = DAMAGE_SWORD*0.1,
		SKILL_PRAYER = DAMAGE_SWORD*0.5
	)

	skill_damage = list(
		SKILL_MELEE = BLUNT,
		SKILL_PRAYER = HOLY
	)

	attack_delay = SPEED_SWORD*0.5
	attack_delay_max = SPEED_SWORD