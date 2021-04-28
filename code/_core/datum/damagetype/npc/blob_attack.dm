/damagetype/blob_attack/
	name = "blob"

	impact_sounds = list(
		'sound/effects/impacts/blob_impact.ogg'
	)

	//The base attack damage of the weapon. It's a flat value, unaffected by any skills or attributes.
	attack_damage_base = list(
		BLUNT = 60*0.5,
		BIO = 60*0.5
	)

	//How much armor to penetrate. It basically removes the percentage of the armor using these values.
	attack_damage_penetration = list(
		BLUNT = 60*0.8,
		BIO = 60*0.2
	)

	attack_delay = 14*0.5
	attack_delay_max = 14