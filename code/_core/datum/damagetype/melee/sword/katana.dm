/damagetype/melee/sword/katana
	name = "katana"

	//The base attack damage of the weapon. It's a flat value, unaffected by any skills or attributes.
	attack_damage_base = list(
		BLADE = DAMAGE_SWORD*0.2*BASE_MELEE_MUL,
		PIERCE = DAMAGE_SWORD*0.1*BASE_MELEE_MUL
	)

	//How much armor to penetrate. It basically removes the percentage of the armor using these values.
	attack_damage_penetration = list(
		BLADE = AP_SWORD*0.4,
		PIERCE = AP_SWORD*0.6
	)

	attribute_stats = list(
		ATTRIBUTE_DEXTERITY = DAMAGE_SWORD*0.4
	)

	attribute_damage = list(
		ATTRIBUTE_STRENGTH = list(BLADE,PIERCE),
		ATTRIBUTE_DEXTERITY = list(BLADE,PIERCE)
	)

	skill_stats = list(
		SKILL_MELEE = DAMAGE_SWORD*0.3,
	)

	skill_damage = list(
		SKILL_MELEE = list(BLADE,PIERCE)
	)

	attack_delay = SPEED_SWORD*0.5
	attack_delay_max = SPEED_SWORD