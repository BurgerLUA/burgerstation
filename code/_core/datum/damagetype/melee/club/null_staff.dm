/damagetype/melee/club/null_staff
	name = "null staff"
	id = "null_staff"

	attack_damage_base = list(
		BLUNT = 5,
		HOLY = 20
	)

	attack_damage_conversion = list(
		BLUNT = BRUTE,
		HOLY = BURN
	)

	attack_damage_penetration = list(
		BLADE = 15,
		HOLY = 20
	)

	attribute_stats = list(
		ATTRIBUTE_STRENGTH = CLASS_D,
		ATTRIBUTE_DEXTERITY = CLASS_C
	)

	attribute_damage = list(
		ATTRIBUTE_STRENGTH = BLUNT,
		ATTRIBUTE_DEXTERITY = BLUNT
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