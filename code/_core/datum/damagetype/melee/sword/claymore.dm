/damagetype/melee/sword/claymore
	name = "claymore"

	//The base attack damage of the weapon. It's a flat value, unaffected by any skills or attributes.
	attack_damage_base = list(
		BLADE = 45*0.3,
		PIERCE = 45*0.1,
	)

	//How much armor to penetrate. It basically removes the percentage of the armor using these values.
	attack_damage_penetration = list(
		BLADE = 40*0.75,
		PIERCE = 40*0.25,
	)

	attribute_stats = list(
		ATTRIBUTE_STRENGTH = 45*0.2,
		ATTRIBUTE_DEXTERITY = 45*0.2,
	)

	attribute_damage = list(
		ATTRIBUTE_STRENGTH = list(BLADE,PIERCE),
		ATTRIBUTE_DEXTERITY = list(BLADE,PIERCE)
	)

	skill_stats = list(
		SKILL_MELEE = 45*0.2
	)

	skill_damage = list(
		SKILL_MELEE = list(BLADE,PIERCE)
	)

	attack_delay = 12*0.5
	attack_delay_max = 12

/damagetype/melee/sword/claymore/cult
	name = "cult claymore"

	//The base attack damage of the weapon. It's a flat value, unaffected by any skills or attributes.
	attack_damage_base = list(
		BLADE = 60*0.2,
		PIERCE = 60*0.1,
		DARK = 60*0.2
	)

	//How much armor to penetrate. It basically removes the percentage of the armor using these values.
	attack_damage_penetration = list(
		BLADE = 60*0.5,
		PIERCE = 60*0.5,
		UNHOLY = 0
	)

	attribute_stats = list(
		ATTRIBUTE_STRENGTH = 60*0.1,
		ATTRIBUTE_DEXTERITY = 60*0.1,
	)

	attribute_damage = list(
		ATTRIBUTE_STRENGTH = list(BLADE,PIERCE),
		ATTRIBUTE_DEXTERITY = list(BLADE,PIERCE)
	)

	skill_stats = list(
		SKILL_MELEE = 60*0.1,
		SKILL_PRAYER = 60*0.1
	)

	skill_damage = list(
		SKILL_MELEE = list(BLADE,PIERCE),
		SKILL_PRAYER = DARK
	)

	bonus_experience_skill = list(
		SKILL_MELEE = 25, //25%
		SKILL_PRAYER = 25
	)

	attack_delay = 14*0.5
	attack_delay_max = 14