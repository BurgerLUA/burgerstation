/damagetype/blob_attack/
	name = "blob"

	impact_sounds = list(
		'sounds/effects/impacts/blob_impact.ogg'
	)

	//The base attack damage of the weapon. It's a flat value, unaffected by any skills or attributes.
	attack_damage_base = list(
		BLADE = 5,
		BLUNT = 10,
		PIERCE = 5,
		BIO = 20,
		FATIGUE = 10
	)

	//How much armor to penetrate. It basically removes the percentage of the armor using these values.
	attack_damage_penetration = list(
		BLADE = 25,
		BLUNT = 25,
		PIERCE = 25,
		BIO = 25,
		FATIGUE = 25
	)


	attribute_stats = list(
	)

	attribute_damage = list(
	)

	skill_stats = list(
	)

	skill_damage = list(
	)