/damagetype/melee/sword/katana
	name = "katana"

	//The base attack damage of the weapon. It's a flat value, unaffected by any skills or attributes.
	attack_damage_base = list(
		BLADE = 40,
		PIERCE = 10
	)

	//How much armor to penetrate. It basically removes the percentage of the armor using these values.
	attack_damage_penetration = list(
		BLADE = 75,
		PIERCE = 75
	)

	attribute_stats = list(
		ATTRIBUTE_DEXTERITY = 50
	)

	attribute_damage = list(
		ATTRIBUTE_STRENGTH = list(BLADE,PIERCE),
		ATTRIBUTE_DEXTERITY = list(BLADE,PIERCE)
	)

	skill_stats = list(
		SKILL_MELEE = 60,
	)

	skill_damage = list(
		SKILL_MELEE = list(BLADE,PIERCE)
	)