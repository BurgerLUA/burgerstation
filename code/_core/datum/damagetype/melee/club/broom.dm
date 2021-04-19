/damagetype/melee/club/broom
	name = "broom"
	attack_verbs = list("sweeps")

	attack_damage_base = list(
		BLUNT = 30*0.1
	)

	attack_damage_penetration = list(
		BLUNT = 20
	)

	attribute_stats = list(
		ATTRIBUTE_STRENGTH = 30*0.7
	)

	attribute_damage = list(
		ATTRIBUTE_STRENGTH = BLUNT
	)

	skill_stats = list(
		SKILL_MELEE = 30*0.2,
	)

	skill_damage = list(
		SKILL_MELEE = BLUNT
	)

	attack_delay = 10*0.5
	attack_delay_max = 10