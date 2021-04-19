/damagetype/npc/slime
	name = "slime touch"
	attack_verbs = list("blob","pounce","absorb","slime")


	//The base attack damage of the weapon. It's a flat value, unaffected by any skills or attributes.
	attack_damage_base = list(
		BLUNT = 45*0.2,
		BIO = 45*0.3
	)

	//How much armor to penetrate. It basically removes the percentage of the armor using these values.
	attack_damage_penetration = list(
		BLUNT = 40*0.3,
		BIO = 40*0.7
	)

	attribute_stats = list(
		ATTRIBUTE_VITALITY = 45*0.5,
	)

	attribute_damage = list(
		ATTRIBUTE_VITALITY = BIO
	)

	attack_delay = 12*0.5
	attack_delay_max = 12