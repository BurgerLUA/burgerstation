/damagetype/melee/spear/ratvar/
	name = "spear"

	attack_damage_base = list(
		PIERCE = DAMAGE_AXE*0.2*BASE_MELEE_MUL,
		BLADE = DAMAGE_AXE*0.2*BASE_MELEE_MUL,
		HOLY = DAMAGE_AXE*0.1*BASE_MELEE_MUL
	)

	attack_damage_penetration = list(
		PIERCE = AP_AXE*0.9,
		BLADE = AP_AXE*0.1
	)

	attribute_stats = list(
		ATTRIBUTE_STRENGTH = DAMAGE_AXE*0.1,
		ATTRIBUTE_DEXTERITY = DAMAGE_AXE*0.1
	)

	attribute_damage = list(
		ATTRIBUTE_STRENGTH = PIERCE,
		ATTRIBUTE_DEXTERITY = PIERCE
	)

	skill_stats = list(
		SKILL_MELEE = DAMAGE_AXE*0.2,
		SKILL_PRAYER = DAMAGE_AXE*0.1
	)

	skill_damage = list(
		SKILL_MELEE = PIERCE,
		SKILL_PRAYER = HOLY
	)

	attack_delay = SPEED_AXE*0.5
	attack_delay_max = SPEED_AXE