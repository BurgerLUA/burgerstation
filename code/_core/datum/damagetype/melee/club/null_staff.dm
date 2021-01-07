/damagetype/melee/club/null_staff
	name = "null staff"

	attack_damage_base = list(
		BLUNT = DAMAGE_AXE*0.2*BASE_MELEE_MUL,
		HOLY = 0
	)

	attack_damage_penetration = list(
		BLUNT = AP_AXE*0.25,
		HOLY = AP_AXE*0.75
	)

	attribute_stats = list(
		ATTRIBUTE_STRENGTH = DAMAGE_AXE*0.1,
		ATTRIBUTE_DEXTERITY = DAMAGE_AXE*0.2
	)

	attribute_damage = list(
		ATTRIBUTE_STRENGTH = BLUNT
	)

	skill_stats = list(
		SKILL_MELEE = DAMAGE_AXE*0.1,
		SKILL_PRAYER = DAMAGE_AXE*0.40
	)

	skill_damage = list(
		SKILL_MELEE = BLUNT,
		SKILL_PRAYER = HOLY
	)

	bonus_experience = list(
		SKILL_MELEE = 25, //25%
		SKILL_PRAYER = 25
	)

	attack_delay = SPEED_AXE*0.5
	attack_delay_max = SPEED_AXE