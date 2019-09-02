/damagetype/melee/spear/
	name = "spear"
	id = "spear"

	//

	attack_damage_base = list(
		PIERCE = 10,
		BLADE = 5
	)

	attack_damage_conversion = list(
		PIERCE = BRUTE,
		BLADE = BRUTE
	)

	attack_damage_penetration = list(
		PIERCE = 25
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
		SKILL_MELEE = 1
	)