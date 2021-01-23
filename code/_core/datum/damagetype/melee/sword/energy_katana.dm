/damagetype/melee/sword/energy_katana
	name = "inactive energy sword"

	//The base attack damage of the weapon. It's a flat value, unaffected by any skills or attributes.
	attack_damage_base = list(
		BLUNT = DAMAGE_AXE*0.1*BASE_MELEE_MUL,
		FATIGUE = DAMAGE_AXE*0.5*BASE_MELEE_MUL
	)

	//How much armor to penetrate. It basically removes the percentage of the armor using these values.
	attack_damage_penetration = list(
		BLUNT = AP_AXE*0.25,
		FATIGUE = AP_AXE*0.75
	)

	attribute_stats = list(
		ATTRIBUTE_STRENGTH = DAMAGE_AXE*0.3
	)

	attribute_damage = list(
		ATTRIBUTE_STRENGTH = BLUNT
	)

	skill_stats = list(
		SKILL_MELEE = DAMAGE_AXE*0.1,
	)

	skill_damage = list(
		SKILL_MELEE = BLUNT
	)

	attack_delay = SPEED_AXE*0.5
	attack_delay_max = SPEED_AXE

/damagetype/melee/sword/energy_katana/on
	name = "energy katana"

	//The base attack damage of the weapon. It's a flat value, unaffected by any skills or attributes.
	attack_damage_base = list(
		BLADE = DAMAGE_CLUB*0.2*BASE_MELEE_MUL,
		LASER = DAMAGE_CLUB*0.2*BASE_MELEE_MUL,
		HEAT = DAMAGE_CLUB*0.1*BASE_MELEE_MUL
	)

	//How much armor to penetrate. It basically removes the percentage of the armor using these values.
	attack_damage_penetration = list(
		BLADE = AP_CLUB*0.5,
		LASER = AP_CLUB*0.5
	)

	attribute_stats = list(
		ATTRIBUTE_STRENGTH = DAMAGE_CLUB*0.1,
		ATTRIBUTE_DEXTERITY = DAMAGE_CLUB*0.2
	)

	attribute_damage = list(
		ATTRIBUTE_STRENGTH = list(BLADE,LASER),
		ATTRIBUTE_DEXTERITY = list(BLADE,LASER)
	)

	skill_stats = list(
		SKILL_MELEE = DAMAGE_CLUB*0.2,
	)

	skill_damage = list(
		SKILL_MELEE = BLADE
	)

	attack_delay = SPEED_CLUB*0.5
	attack_delay_max = SPEED_CLUB