/damagetype/melee/sword/energy_katana
	name = "inactive energy sword"

	//The base attack damage of the weapon. It's a flat value, unaffected by any skills or attributes.
	attack_damage_base = list(
		BLUNT = 45*0.1,
		FATIGUE = 45*0.5
	)

	//How much armor to penetrate. It basically removes the percentage of the armor using these values.
	attack_damage_penetration = list(
		BLUNT = 40*0.25,
		FATIGUE = 40*0.75
	)

	attribute_stats = list(
		ATTRIBUTE_STRENGTH = 45*0.3
	)

	attribute_damage = list(
		ATTRIBUTE_STRENGTH = BLUNT
	)

	skill_stats = list(
		SKILL_MELEE = 45*0.1,
	)

	skill_damage = list(
		SKILL_MELEE = BLUNT
	)

	attack_delay = 12*0.5
	attack_delay_max = 12

/damagetype/melee/sword/energy_katana/on
	name = "energy katana"

	//The base attack damage of the weapon. It's a flat value, unaffected by any skills or attributes.
	attack_damage_base = list(
		BLADE = DAMAGE_CLUB*0.2,
		LASER = DAMAGE_CLUB*0.2,
		HEAT = DAMAGE_CLUB*0.1
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