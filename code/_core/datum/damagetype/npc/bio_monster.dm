/damagetype/npc/bio_monster
	name = "Biomonster attack"

	//The base attack damage of the weapon. It's a flat value, unaffected by any skills or attributes.
	attack_damage_base = list(
		BIO = 60*0.5
	)

	//How much armor to penetrate. It basically removes the percentage of the armor using these values.
	attack_damage_penetration = list(
		BIO = 60*1,
	)

	attribute_stats = list(
		ATTRIBUTE_STRENGTH = 60*0.5
	)

	attribute_damage = list(
		ATTRIBUTE_STRENGTH = BIO
	)

	attack_delay = 14*0.5
	attack_delay_max = 14