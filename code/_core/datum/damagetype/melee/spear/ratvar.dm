/damagetype/melee/spear/ratvar/
	name = "spear"

	attack_damage_base = list(
		PIERCE = 20,
		BLADE = 10,
		HOLY = 0
	)

	attack_damage_penetration = list(
		PIERCE = 75,
		BLADE = 75,
		HOLY = 75
	)

	attribute_stats = list(
		ATTRIBUTE_STRENGTH = 15,
		ATTRIBUTE_DEXTERITY = 15
	)

	attribute_damage = list(
		ATTRIBUTE_STRENGTH = PIERCE,
		ATTRIBUTE_DEXTERITY = PIERCE
	)

	skill_stats = list(
		SKILL_MELEE = 40,
		SKILL_PRAYER = 50
	)

	skill_damage = list(
		SKILL_MELEE = PIERCE,
		SKILL_PRAYER = HOLY
	)

	attack_delay = 10
	attack_delay_max = 20