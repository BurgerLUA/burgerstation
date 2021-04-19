/damagetype/melee/spear/basic/
	name = "spear"

	attack_damage_base = list(
		PIERCE = 45*0.3,
		BLADE = 45*0.1
	)

	attack_damage_penetration = list(
		PIERCE = 40*0.75,
		BLADE = 40*0.25
	)

	attribute_stats = list(
		ATTRIBUTE_STRENGTH = 45*0.2,
		ATTRIBUTE_DEXTERITY = 45*0.1
	)

	attribute_damage = list(
		ATTRIBUTE_STRENGTH = PIERCE,
		ATTRIBUTE_DEXTERITY = PIERCE
	)

	skill_stats = list(
		SKILL_MELEE = 45*0.3
	)

	skill_damage = list(
		SKILL_MELEE = PIERCE
	)

	attack_delay = 12*0.5
	attack_delay_max = 12

/damagetype/melee/spear/basic/thrown

	name = "thrown spear"

	attack_damage_base = list(
		PIERCE = DAMAGE_GREATSWORD*0.35,
		BLADE = DAMAGE_GREATSWORD*0.05
	)

	attack_damage_penetration = list(
		PIERCE = 40,
		BLADE = 0
	)

	attribute_stats = list(
		ATTRIBUTE_STRENGTH = DAMAGE_GREATSWORD*0.4,
		ATTRIBUTE_DEXTERITY = DAMAGE_GREATSWORD*0.1
	)

	attribute_damage = list(
		ATTRIBUTE_STRENGTH = PIERCE,
		ATTRIBUTE_DEXTERITY = PIERCE
	)

	skill_stats = list(
		SKILL_MELEE = DAMAGE_GREATSWORD*0.1
	)

	skill_damage = list(
		SKILL_MELEE = PIERCE,
		SKILL_RANGED = PIERCE
	)

	attack_delay = SPEED_GREATSWORD*0.5
	attack_delay_max = SPEED_GREATSWORD