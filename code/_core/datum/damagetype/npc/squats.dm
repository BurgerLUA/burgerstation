/damagetype/squats/
	name = "squats punch"

	//The base attack damage of the weapon. It's a flat value, unaffected by any skills or attributes.
	attack_damage_base = list(
		BLUNT = 60*0.4,
	)

	//How much armor to penetrate. It basically removes the percentage of the armor using these values.
	attack_damage_penetration = list(
		BLUNT = 60
	)

	attribute_stats = list(
		ATTRIBUTE_STRENGTH = 60*0.4,
		ATTRIBUTE_DEXTERITY = 60*0.2
	)

	attribute_damage = list(
		ATTRIBUTE_STRENGTH = BLUNT,
		ATTRIBUTE_DEXTERITY = PIERCE,
	)

	attack_delay = 14*0.5
	attack_delay_max = 14