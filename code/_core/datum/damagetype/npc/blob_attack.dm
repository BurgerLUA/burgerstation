/damagetype/blob_attack/
	name = "blob"

	impact_sounds = list(
		'sound/effects/impacts/blob_impact.ogg'
	)

	//The base attack damage of the weapon. It's a flat value, unaffected by any skills or attributes.
	attack_damage_base = list(
		BLUNT = 10,
		HEAT = 10,
		BIO = 20
	)

	//How much armor to penetrate. It basically removes the percentage of the armor using these values.
	attack_damage_penetration = list(
		BLUNT = 25,
		HEAT = 25,
		BIO = 0
	)

	attribute_stats = list(
	)

	attribute_damage = list(
	)

	skill_stats = list(
	)

	skill_damage = list(
	)