/damagetype/ranged/bow/hardlight
	name = "bow"

	attack_damage_base = list(
		LASER = DAMAGE_GREATCLUB*0.50,
		HEAT = DAMAGE_GREATCLUB*0.25
	)

	attack_damage_penetration = list(
		LASER = AP_GREATCLUB*0.5,
		HEAT = AP_GREATCLUB*0.5
	)

	skill_stats = list(
		SKILL_RANGED = DAMAGE_GREATCLUB*0.25
	)

	skill_damage = list(
		SKILL_RANGED = list(LASER,HEAT)
	)