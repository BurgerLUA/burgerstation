/damagetype/ranged/magic/magic_missile
	name = "magic missile"

	//The base attack damage of the weapon. It's a flat value, unaffected by any skills or attributes.
	attack_damage_base = list(
		MAGIC = 15,
		PIERCE = 5,
		BOMB = 10
	)

	//How much armor to penetrate. It basically removes the percentage of the armor using these values.
	attack_damage_penetration = list(
		MAGIC = 25,
		PIERCE = 25,
		BOMB = 25
	)

	attribute_stats = list(
		ATTRIBUTE_INTELLIGENCE = 50
	)

	attribute_damage = list(
		ATTRIBUTE_INTELLIGENCE = list(MAGIC,PIERCE,BOMB)
	)

	skill_stats = list(
		SKILL_MAGIC = 50
	)

	skill_damage = list(
		SKILL_MAGIC = list(MAGIC,PIERCE,BOMB)
	)