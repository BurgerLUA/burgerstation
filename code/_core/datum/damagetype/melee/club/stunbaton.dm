/damagetype/melee/club/stunbaton
	name = "inactive stunbaton"

	//The base attack damage of the weapon. It's a flat value, unaffected by any skills or attributes.
	attack_damage_base = list(
		BLUNT = DAMAGE_CLUB*0.2*BASE_MELEE_MUL
	)

	attribute_stats = list(
		ATTRIBUTE_STRENGTH = DAMAGE_CLUB*0.5,
		ATTRIBUTE_DEXTERITY = DAMAGE_CLUB*0.1
	)

	attribute_damage = list(
		ATTRIBUTE_STRENGTH = BLUNT,
		ATTRIBUTE_DEXTERITY = BLUNT
	)

	skill_stats = list(
		SKILL_MELEE = DAMAGE_CLUB*0.2
	)

	skill_damage = list(
		SKILL_MELEE = BLUNT
	)

	attack_delay = SPEED_CLUB*0.5
	attack_delay_max = SPEED_CLUB

/damagetype/melee/club/stunbaton/on
	name = "active stunbaton"

	//The base attack damage of the weapon. It's a flat value, unaffected by any skills or attributes.
	attack_damage_base = list(
		FATIGUE = DAMAGE_CLUB*0.8,
		ION = DAMAGE_CLUB*0.2
	)

	//How much armor to penetrate. It basically removes the percentage of the armor using these values.
	attack_damage_penetration = list(
		FATIGUE = AP_CLUB
	)

	attribute_stats = list()

	attribute_damage = list()

	skill_stats = list()

	skill_damage = list()

	attack_delay = SPEED_CLUB*0.5
	attack_delay_max = SPEED_CLUB


/damagetype/melee/club/stunbaton/on/harm
	name = "active stunbaton"

	//The base attack damage of the weapon. It's a flat value, unaffected by any skills or attributes.
	attack_damage_base = list(
		BLUNT = DAMAGE_CLUB*0.1,
		FATIGUE = DAMAGE_CLUB*0.3,
		ION = DAMAGE_CLUB*0.1
	)

	attack_damage_penetration = list(
		FATIGUE = AP_CLUB
	)

	attribute_stats = list(
		ATTRIBUTE_STRENGTH = DAMAGE_CLUB*0.3,
		ATTRIBUTE_DEXTERITY = DAMAGE_CLUB*0.1
	)

	attribute_damage = list(
		ATTRIBUTE_STRENGTH = BLUNT,
		ATTRIBUTE_DEXTERITY = BLUNT
	)

	skill_stats = list(
		SKILL_MELEE = DAMAGE_CLUB*0.1
	)

	skill_damage = list(
		SKILL_MELEE = BLUNT
	)

	attack_delay = SPEED_CLUB*0.5
	attack_delay_max = SPEED_CLUB