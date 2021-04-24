/damagetype/melee/spear/basic/
	name = "spear"

	attack_damage_base = list(
		PIERCE = 15,
		BLADE = 5
	)

	attack_damage_penetration = list(
		PIERCE = 50,
		BLADE = 50
	)

	attribute_stats = list(
		ATTRIBUTE_STRENGTH = 20,
		ATTRIBUTE_DEXTERITY = 20
	)

	attribute_damage = list(
		ATTRIBUTE_STRENGTH = PIERCE,
		ATTRIBUTE_DEXTERITY = PIERCE
	)

	skill_stats = list(
		SKILL_MELEE = 30
	)

	skill_damage = list(
		SKILL_MELEE = PIERCE
	)

	attack_delay = 8
	attack_delay_max = 12

/damagetype/melee/spear/basic/thrown

	name = "thrown spear"

	attack_damage_base = list(
		PIERCE = 40,
		BLADE = 10
	)

	attack_damage_penetration = list(
		PIERCE = 100,
		BLADE = 0
	)

	attribute_stats = list(
		ATTRIBUTE_STRENGTH = 50,
		ATTRIBUTE_DEXTERITY = 30
	)

	attribute_damage = list(
		ATTRIBUTE_STRENGTH = PIERCE,
		ATTRIBUTE_DEXTERITY = PIERCE
	)

	skill_stats = list(
		SKILL_MELEE = 30
	)

	skill_damage = list(
		SKILL_MELEE = PIERCE,
		SKILL_RANGED = PIERCE
	)

	attack_delay = 20
	attack_delay_max = 20