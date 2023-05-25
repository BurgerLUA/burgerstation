/damagetype/melee/sword/cblade

	//The base attack damage of the weapon. It's a flat value, unaffected by any skills or attributes.
	attack_damage_base = list(
		BLADE = 40,
		BLUNT = 20
	)

	//How much armor to penetrate. It basically removes the percentage of the armor using these values.
	attack_damage_penetration = list(
		BLADE = 50,
		BLUNT = 50
	)

	attribute_stats = list(
		ATTRIBUTE_STRENGTH = 60,
		ATTRIBUTE_DEXTERITY = 20
	)

	attribute_damage = list(
		ATTRIBUTE_STRENGTH = list(BLADE,PIERCE),
		ATTRIBUTE_DEXTERITY = list(BLADE,PIERCE)
	)

	skill_stats = list(
		SKILL_MELEE = 30
	)

	skill_damage = list(
		SKILL_MELEE = list(BLADE,PIERCE)
	)

	attack_delay = 15
	attack_delay_max = 25