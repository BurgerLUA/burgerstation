/damagetype/npc/slime
	name = "slime touch"
	attack_verbs = list("blob","pounce","absorb","slime")


	//The base attack damage of the weapon. It's a flat value, unaffected by any skills or attributes.
	attack_damage_base = list(
		BIO = 20,
	)

	//How much armor to penetrate. It basically removes the percentage of the armor using these values.
	attack_damage_penetration = list(
		BIO = 75,
	)

	attribute_stats = list(
		ATTRIBUTE_VITALITY = 50,
	)

	attribute_damage = list(
		ATTRIBUTE_VITALITY = BIO
	)