/damagetype/melee/sword/grazer
	name = "inactive grazer"

	attack_damage_base = list(
		BLADE = 15*0.5,
	)

	//How much armor to penetrate. It basically removes the percentage of the armor using these values.
	attack_damage_penetration = list(
		BLADE = 10
	)

	attribute_stats = list(
		ATTRIBUTE_STRENGTH = 15*0.1,
		ATTRIBUTE_DEXTERITY = 15*0.2,
	)

	attribute_damage = list(
		ATTRIBUTE_STRENGTH = BLADE,
		ATTRIBUTE_DEXTERITY = BLADE
	)

	skill_stats = list(
		SKILL_MELEE = 15*0.2
	)

	skill_damage = list(
		SKILL_MELEE = BLADE
	)

	attack_delay = 8*0.5
	attack_delay_max = 8

/damagetype/melee/sword/grazer/on
	name = "active grazer"

	attack_damage_base = list(
		LASER = DAMAGE_SWORD*0.4,
		HEAT = DAMAGE_SWORD*0.1,
	)

	//How much armor to penetrate. It basically removes the percentage of the armor using these values.
	attack_damage_penetration = list(
		LASER = AP_SWORD*0.75,
		HEAT = AP_SWORD*0.25,
	)

	attribute_stats = list(
		ATTRIBUTE_STRENGTH = DAMAGE_SWORD*0.1,
		ATTRIBUTE_DEXTERITY = DAMAGE_SWORD*0.2,
	)

	attribute_damage = list(
		ATTRIBUTE_STRENGTH = LASER,
		ATTRIBUTE_DEXTERITY = LASER
	)

	skill_stats = list(
		SKILL_MELEE = DAMAGE_SWORD*0.2
	)

	skill_damage = list(
		SKILL_MELEE = LASER
	)

	attack_delay = SPEED_SWORD*0.5
	attack_delay_max = SPEED_SWORD