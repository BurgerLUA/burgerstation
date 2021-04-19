/damagetype/melee/sword/energy
	name = "inactive energy sword"

	//The base attack damage of the weapon. It's a flat value, unaffected by any skills or attributes.
	attack_damage_base = list(
		BLUNT = 30*0.1,
		FATIGUE = 30*0.5
	)

	//How much armor to penetrate. It basically removes the percentage of the armor using these values.
	attack_damage_penetration = list(
		BLUNT = 20*0.25,
		FATIGUE = 20*0.75
	)

	attribute_stats = list(
		ATTRIBUTE_STRENGTH = 30*0.3
	)

	attribute_damage = list(
		ATTRIBUTE_STRENGTH = BLUNT
	)

	skill_stats = list(
		SKILL_MELEE = 30*0.1,
	)

	skill_damage = list(
		SKILL_MELEE = BLUNT
	)

	attack_delay = 10*0.5
	attack_delay_max = 10


/damagetype/melee/sword/energy/on
	name = "energy sword"

	//The base attack damage of the weapon. It's a flat value, unaffected by any skills or attributes.
	attack_damage_base = list(
		BLADE = DAMAGE_AXE*0.1,
		LASER = DAMAGE_AXE*0.4,
		HEAT = DAMAGE_AXE*0.1
	)

	//How much armor to penetrate. It basically removes the percentage of the armor using these values.
	attack_damage_penetration = list(
		BLADE = AP_AXE*0.1,
		LASER = AP_AXE*0.8,
		HEAT = AP_AXE*0.1
	)

	attribute_stats = list(
		ATTRIBUTE_STRENGTH = DAMAGE_AXE*0.1,
		ATTRIBUTE_DEXTERITY = DAMAGE_AXE*0.2
	)

	attribute_damage = list(
		ATTRIBUTE_STRENGTH = list(BLADE,LASER),
		ATTRIBUTE_DEXTERITY = list(BLADE,LASER)
	)

	skill_stats = list(
		SKILL_MELEE = DAMAGE_AXE*0.1,
	)

	skill_damage = list(
		SKILL_MELEE = LASER
	)

	attack_delay = SPEED_AXE*0.5
	attack_delay_max = SPEED_AXE