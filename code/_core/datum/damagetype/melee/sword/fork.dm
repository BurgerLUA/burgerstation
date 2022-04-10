/damagetype/melee/sword/fork

	//The base attack damage of the weapon. It's a flat value, unaffected by any skills or attributes.
	attack_damage_base = list(
		BLUNT = 5,
		PIERCE = 10
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
		ATTRIBUTE_STRENGTH = list(BLUNT,PIERCE),
		ATTRIBUTE_DEXTERITY = list(BLUNT,PIERCE)
	)

	skill_stats = list(
		SKILL_MELEE = 10
	)

	skill_damage = list(
		SKILL_MELEE = list(BLUNT,PIERCE)
	)

	attack_delay = 4
	attack_delay_max = 7