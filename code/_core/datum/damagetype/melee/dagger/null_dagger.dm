/damagetype/melee/dagger/null_dagger
	name = "null dagger"
	id = "null_dagger"

	attack_damage_base = list(
		BLADE = DAMAGE_C,
		PIERCE = DAMAGE_D,
		HOLY = DAMAGE_B
	)

	attack_damage_conversion = list(
		BLADE = BRUTE,
		HOLY = BURN
	)

	attack_damage_penetration = list(
		PIERCE = ARMOR_D,
		HOLY = ARMOR_S
	)

	attribute_stats = list(
		ATTRIBUTE_STRENGTH = CLASS_D,
		ATTRIBUTE_DEXTERITY = CLASS_C
	)

	attribute_damage = list(
		ATTRIBUTE_STRENGTH = PIERCE,
		ATTRIBUTE_DEXTERITY = BLADE
	)

	skill_stats = list(
		SKILL_MELEE = CLASS_C,
		SKILL_PRAYER = CLASS_A
	)

	skill_damage = list(
		SKILL_MELEE = BLADE,
		SKILL_PRAYER = HOLY
	)

	skill_xp_per_damage = list(
		SKILL_PRAYER = SKILL_A,
		SKILL_MELEE = SKILL_D
	)