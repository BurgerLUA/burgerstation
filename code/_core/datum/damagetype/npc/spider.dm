/damagetype/npc/spider
	name = "spider fang"
	attack_verbs = list("bite","chomp","scratch")


	//The base attack damage of the weapon. It's a flat value, unaffected by any skills or attributes.
	attack_damage_base = list(
		PIERCE = 45*0.3,
		BIO = 45*0.2
	)

	//How much armor to penetrate. It basically removes the percentage of the armor using these values.
	attack_damage_penetration = list(
		PIERCE = 40*0.5,
		BIO = 40*0.5
	)

	attribute_stats = list(
		ATTRIBUTE_STRENGTH = 45*0.3,
		ATTRIBUTE_VITALITY = 45*0.2
	)

	attribute_damage = list(
		ATTRIBUTE_STRENGTH = PIERCE,
		ATTRIBUTE_VITALITY = BIO
	)

	attack_delay = 12*0.5
	attack_delay_max = 12