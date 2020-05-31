/damagetype/ranged/magic/crystal
	name = "magic crystal"

	//The base attack damage of the weapon. It's a flat value, unaffected by any skills or attributes.
	attack_damage_base = list(
		MAGIC = 10,
		PIERCE = 20,
		BLADE = 10,
	)

	//How much armor to penetrate. It basically removes the percentage of the armor using these values.
	attack_damage_penetration = list(
		MAGIC = 50,
		PIERCE = 50,
		BLADE = 50,
	)

	attribute_stats = list(
		ATTRIBUTE_INTELLIGENCE = 50
	)

	attribute_damage = list(
		ATTRIBUTE_INTELLIGENCE = list(MAGIC,PIERCE,BLADE)
	)

	skill_stats = list(
		SKILL_MAGIC = 50
	)

	skill_damage = list(
		SKILL_MAGIC = list(MAGIC,PIERCE,BLADE)
	)