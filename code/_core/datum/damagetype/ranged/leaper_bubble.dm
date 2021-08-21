/damagetype/ranged/leaper_bubble/
	name = "leaper bubble"

	//The base attack damage of the weapon. It's a flat value, unaffected by any skills or attributes.
	attack_damage_base = list(
		BIO = 45*0.25,
		DARK = 25*0.75,
		BLUNT = 20*0.75
	)

	//How much armor to penetrate. It basically removes the percentage of the armor using these values.
	attack_damage_penetration = list(
		BIO = 0,
		DARK = 5,
		BLUNT = 10
	)

	attribute_stats = list()

	attribute_damage = list()

	skill_stats = list()

	skill_damage = list()