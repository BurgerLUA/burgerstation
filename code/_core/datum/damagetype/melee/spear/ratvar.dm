/damagetype/melee/spear/ratvar/
	name = "spear"

	attack_damage_base = list(
		PIERCE = 45*0.2,
		BLADE = 45*0.2,
		HOLY = 45*0.1
	)

	attack_damage_penetration = list(
		PIERCE = 40*0.9,
		BLADE = 40*0.1
	)

	attribute_stats = list(
		ATTRIBUTE_STRENGTH = 45*0.1,
		ATTRIBUTE_DEXTERITY = 45*0.1
	)

	attribute_damage = list(
		ATTRIBUTE_STRENGTH = PIERCE,
		ATTRIBUTE_DEXTERITY = PIERCE
	)

	skill_stats = list(
		SKILL_MELEE = 45*0.2,
		SKILL_PRAYER = 45*0.1
	)

	skill_damage = list(
		SKILL_MELEE = PIERCE,
		SKILL_PRAYER = HOLY
	)

	attack_delay = 12*0.5
	attack_delay_max = 12