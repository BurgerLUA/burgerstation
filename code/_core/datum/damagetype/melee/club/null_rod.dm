/damagetype/melee/club/null_rod
	name = "null rod"
	id = "null_rod"

	attack_damage_base = list(
		BLUNT = 10,
		HOLY = 20,
		FATIGUE = 10
	)

	attack_damage_conversion = list(
		BLUNT = BRUTE,
		HOLY = BURN,
		FATIGUE = OXY
	)

	attack_damage_penetration = list(
		BLADE = 5,
		HOLY = 20
	)

	attribute_stats = list(
		ATTRIBUTE_STRENGTH = CLASS_C,
		ATTRIBUTE_DEXTERITY = CLASS_D
	)

	attribute_damage = list(
		ATTRIBUTE_STRENGTH = BLUNT,
		ATTRIBUTE_DEXTERITY = BLUNT,
		ATTRIBUTE_VITALITY = FATIGUE
	)

	skill_stats = list(
		SKILL_MELEE = CLASS_C,
		SKILL_PRAYER = CLASS_A
	)

	skill_damage = list(
		SKILL_MELEE = BLUNT,
		SKILL_PRAYER = HOLY
	)

	skill_xp_per_damage = list(
		SKILL_PRAYER = 0.5,
		SKILL_MELEE = 0.5
	)