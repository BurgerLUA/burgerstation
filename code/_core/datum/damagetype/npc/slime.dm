/damagetype/npc/slime
	attack_verbs = list("blob","pounce","absorb","slime")


	//The base attack damage of the weapon. It's a flat value, unaffected by any skills or attributes.
	attack_damage_base = list(
		BLUNT = 10,
		BIO = 30
	)

	//How much armor to penetrate. It basically removes the percentage of the armor using these values.
	attack_damage_penetration = list(
		BLUNT = 25,
		BIO = 0
	)

	attribute_stats = list(
		ATTRIBUTE_VITALITY = 50,
	)

	attribute_damage = list(
		ATTRIBUTE_VITALITY = BIO
	)

	attack_delay = 12*0.5
	attack_delay_max = 12

	impact_sounds = list(
		'sound/effects/impacts/slime.ogg',
	)