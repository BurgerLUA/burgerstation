/damagetype/melee/sword/fork

	//The base attack damage of the weapon. It's a flat value, unaffected by any skills or attributes.
	attack_damage_base = list(
		BLUNT = 10,
		BLADE = 5
	)

	//How much armor to penetrate. It basically removes the percentage of the armor using these values.
	attack_damage_penetration = list(
		BLUNT = 25,
		PIERCE = 25
	)

	attribute_stats = list(
		ATTRIBUTE_STRENGTH = 10,
		ATTRIBUTE_DEXTERITY = 10
	)

	attribute_damage = list(
		ATTRIBUTE_STRENGTH = list(BLUNT,BLADE),
		ATTRIBUTE_DEXTERITY = list(BLUNT,BLADE)
	)

	skill_stats = list(
		SKILL_MELEE = 10
	)

	skill_damage = list(
		SKILL_MELEE = list(BLUNT,BLADE)
	)

	attack_delay = 4
	attack_delay_max = 7