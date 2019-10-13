/damagetype/melee/club/null_rod
	name = "null rod"
	id = "null_rod"

	attack_damage_base = list(
		BLUNT = DAMAGE_D,
		HOLY = DAMAGE_B
	)

	attack_damage_penetration = list(
		BLUNT = ARMOR_D,
		HOLY = ARMOR_A
	)

	attribute_stats = list(
		ATTRIBUTE_STRENGTH = CLASS_C,
		ATTRIBUTE_DEXTERITY = CLASS_D
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
		SKILL_PRAYER = SKILL_A,
		SKILL_MELEE = SKILL_C
	)