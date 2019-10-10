/damagetype/ranged/magic/meteor/
	name = "magic meteor"
	id = "meteor"

	//The base attack damage of the weapon. It's a flat value, unaffected by any skills or attributes.
	attack_damage_base = list(
		BLUNT = 10,
		PIERCE = 5,
		MAGIC = 10,
		BOMB = 30
	)

	//The damage conversion table of the weapon. Useful for when you want blade attacks to deal holy damage or something.
	attack_damage_conversion = list(
		BLUNT = BRUTE,
		PIERCE = BRUTE,
		MAGIC = BRUTE,
		BOMB = BRUTE
	)

	//How much armor to penetrate. It basically removes the percentage of the armor using these values.
	attack_damage_penetration = list(
		BLUNT = 25,
		PIERCE = 50,
		MAGIC = 0,
		BOMB = 0
	)

	attribute_stats = list(
		ATTRIBUTE_INTELLIGENCE = CLASS_D
	)

	attribute_damage = list(
		ATTRIBUTE_INTELLIGENCE = BOMB
	)

	skill_stats = list(
		SKILL_MAGIC_OFFENSIVE = CLASS_D,
	)

	skill_damage = list(
		SKILL_MAGIC_OFFENSIVE = BOMB
	)

	skill_xp_per_damage = list(
		SKILL_MAGIC_OFFENSIVE = 1
	)