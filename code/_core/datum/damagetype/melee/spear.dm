/damagetype/melee/spear/
	name = "spear"
	id = "spear"

	attack_damage_base = list(
		PIERCE = DAMAGE_B,
		BLADE = DAMAGE_C
	)

	attack_damage_conversion = list(
		PIERCE = BRUTE,
		BLADE = BRUTE
	)

	attack_damage_penetration = list(
		PIERCE = ARMOR_A
	)

	attribute_stats = list(
		ATTRIBUTE_STRENGTH = CLASS_C,
		ATTRIBUTE_DEXTERITY = CLASS_C
	)

	attribute_damage = list(
		ATTRIBUTE_STRENGTH = PIERCE,
		ATTRIBUTE_DEXTERITY = BLADE
	)

	skill_stats = list(
		SKILL_MELEE = CLASS_C
	)

	skill_damage = list(
		SKILL_MELEE = PIERCE
	)

	skill_xp_per_damage = list(
		SKILL_MELEE = SKILL_B
	)

/damagetype/melee/spear/thrown
	name = "spear"
	id = "spear_thrown"

	attack_damage_base = list(
		PIERCE = DAMAGE_A,
		BLADE = DAMAGE_B
	)

	attack_damage_conversion = list(
		PIERCE = BRUTE,
		BLADE = BRUTE
	)

	attack_damage_penetration = list(
		PIERCE = ARMOR_S
	)

	attribute_stats = list(
		ATTRIBUTE_STRENGTH = CLASS_B,
		ATTRIBUTE_DEXTERITY = CLASS_D
	)

	attribute_damage = list(
		ATTRIBUTE_STRENGTH = PIERCE,
		ATTRIBUTE_DEXTERITY = PIERCE
	)

	skill_stats = list(
		SKILL_MELEE = CLASS_D,
		SKILL_RANGED = CLASS_B
	)

	skill_damage = list(
		SKILL_MELEE = PIERCE,
		SKILL_RANGED = PIERCE
	)

	skill_xp_per_damage = list(
		SKILL_MELEE = SKILL_D,
		SKILL_RANGED = SKILL_B
	)