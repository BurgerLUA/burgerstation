/damagetype/melee/club/holy_cog

	//The base attack damage of the weapon. It's a flat value, unaffected by any skills or attributes.
	attack_damage_base = list(
		BLUNT = 30,
		PIERCE = 15,
		BLADE = 15,
		HOLY = 10
	)
	//How much armor to penetrate. It basically removes the percentage of the armor using these values.
	attack_damage_penetration = list(
		HOLY = 100,
		BLUNT = 75,
		PIERCE = 50,
		BLADE = 50

	)

	attribute_stats = list(
		ATTRIBUTE_STRENGTH = 50
	)

	attribute_damage = list(
		ATTRIBUTE_STRENGTH = list(BLUNT,PIERCE,BLADE)
	)

	skill_stats = list(
		SKILL_MELEE = 40,
		SKILL_PRAYER = 60
	)

	skill_damage = list(
		SKILL_MELEE = BLUNT,
		SKILL_PRAYER = HOLY
	)

	attack_delay = 15
	attack_delay_max = 25