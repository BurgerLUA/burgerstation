/damagetype/npc/medibot
	name = "Medibot Ram"
	attack_verbs = list("ram","drive")

	//The base attack damage of the weapon. It's a flat value, unaffected by any skills or attributes.
	attack_damage_base = list(
		BLUNT = 10
	)

	//How much armor to penetrate. It basically removes the percentage of the armor using these values.
	attack_damage_penetration = list(
		BLUNT = 25
	)

	attribute_stats = list(
		ATTRIBUTE_STRENGTH = 25
	)

	attribute_damage = list(
		ATTRIBUTE_STRENGTH = BLUNT
	)