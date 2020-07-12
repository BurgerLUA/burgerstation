/damagetype/melee/spear/spear/
	name = "spear"

	attack_damage_base = list(
		PIERCE = 20,
		BLADE = 10
	)

	attack_damage_penetration = list(
		PIERCE = 50,
		BLADE = 50
	)

	attribute_stats = list(
		ATTRIBUTE_STRENGTH = 30,
		ATTRIBUTE_DEXTERITY = 20
	)

	attribute_damage = list(
		ATTRIBUTE_STRENGTH = PIERCE,
		ATTRIBUTE_DEXTERITY = BLADE
	)

	skill_stats = list(
		SKILL_MELEE = 30
	)

	skill_damage = list(
		SKILL_MELEE = PIERCE
	)

/damagetype/melee/spear/spear/thrown

	name = "thrown spear"

	attack_damage_base = list(
		PIERCE = 40,
		BLADE = 20
	)

	attack_damage_penetration = list(
		PIERCE = 100,
		BLADE = 100
	)

	attribute_stats = list(
		ATTRIBUTE_STRENGTH = 40,
		ATTRIBUTE_DEXTERITY = 20
	)

	attribute_damage = list(
		ATTRIBUTE_STRENGTH = PIERCE,
		ATTRIBUTE_DEXTERITY = PIERCE
	)

	skill_stats = list(
		SKILL_MELEE = 10,
		SKILL_RANGED = 20
	)

	skill_damage = list(
		SKILL_MELEE = PIERCE,
		SKILL_RANGED = PIERCE
	)