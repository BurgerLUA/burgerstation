/damagetype/melee/spear/basic/
	name = "spear"

	attack_damage_base = list(
		PIERCE = DAMAGE_AXE*0.3*BASE_MELEE_MUL,
		BLADE = DAMAGE_AXE*0.1*BASE_MELEE_MUL
	)

	attack_damage_penetration = list(
		PIERCE = AP_AXE*0.75,
		BLADE = AP_AXE*0.25
	)

	attribute_stats = list(
		ATTRIBUTE_STRENGTH = DAMAGE_AXE*0.2,
		ATTRIBUTE_DEXTERITY = DAMAGE_AXE*0.1
	)

	attribute_damage = list(
		ATTRIBUTE_STRENGTH = PIERCE,
		ATTRIBUTE_DEXTERITY = PIERCE
	)

	skill_stats = list(
		SKILL_MELEE = DAMAGE_AXE*0.3
	)

	skill_damage = list(
		SKILL_MELEE = PIERCE
	)

	attack_delay = SPEED_AXE*0.5
	attack_delay_max = SPEED_AXE

/damagetype/melee/spear/basic/thrown

	name = "thrown spear"

	attack_damage_base = list(
		PIERCE = DAMAGE_GREATSWORD*0.35,
		BLADE = DAMAGE_GREATSWORD*0.05
	)

	attack_damage_penetration = list(
		PIERCE = AP_AXE,
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