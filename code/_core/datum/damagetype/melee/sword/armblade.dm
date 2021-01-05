/damagetype/melee/sword/armblade
	name = "fleshblade"

	//The base attack damage of the weapon. It's a flat value, unaffected by any skills or attributes.
	attack_damage_base = list(
		BLADE = DAMAGE_AXE*0.2*BASE_MELEE_MUL,
		PIERCE = DAMAGE_AXE*0.1*BASE_MELEE_MUL,
		BIO = DAMAGE_AXE*0.2*BASE_MELEE_MUL
	)

	//How much armor to penetrate. It basically removes the percentage of the armor using these values.
	attack_damage_penetration = list(
		BLADE = AP_AXE*0.5,
		PIERCE = AP_AXE*0.25,
		BIO = AP_AXE*0.25
	)

	attribute_stats = list(
		ATTRIBUTE_STRENGTH = DAMAGE_AXE*0.3,
		ATTRIBUTE_DEXTERITY = DAMAGE_AXE*0.1
	)

	attribute_damage = list(
		ATTRIBUTE_STRENGTH = list(BLADE,PIERCE),
		ATTRIBUTE_DEXTERITY = list(BLADE,PIERCE)
	)

	skill_stats = list(
		SKILL_MELEE = DAMAGE_AXE*0.1,
	)

	skill_damage = list(
		SKILL_MELEE = list(BLADE,PIERCE)
	)

	attack_delay = SPEED_AXE*0.5
	attack_delay_max = SPEED_AXE