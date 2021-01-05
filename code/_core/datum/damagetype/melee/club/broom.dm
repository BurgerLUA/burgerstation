/damagetype/melee/club/broom
	name = "broom"
	attack_verbs = list("sweeps")

	attack_damage_base = list(
		BLUNT = DAMAGE_SWORD*0.1*BASE_MELEE_MUL
	)

	attack_damage_penetration = list(
		BLUNT = AP_SWORD
	)

	attribute_stats = list(
		ATTRIBUTE_STRENGTH = DAMAGE_SWORD*0.7
	)

	attribute_damage = list(
		ATTRIBUTE_STRENGTH = BLUNT
	)

	skill_stats = list(
		SKILL_MELEE = DAMAGE_SWORD*0.2,
	)

	skill_damage = list(
		SKILL_MELEE = BLUNT
	)

	attack_delay = SPEED_SWORD*0.5
	attack_delay_max = SPEED_SWORD