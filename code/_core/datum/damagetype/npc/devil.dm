/damagetype/npc/devil_gore
	name = "Devil Gore"

	//The base attack damage of the weapon. It's a flat value, unaffected by any skills or attributes.
	attack_damage_base = list(
		BLUNT = 45*0.2,
		PIERCE = 45*0.3,
	)

	//How much armor to penetrate. It basically removes the percentage of the armor using these values.
	attack_damage_penetration = list(
		BLUNT = 40*0.25,
		PIERCE = 40*0.75,
	)

	attribute_stats = list(
		ATTRIBUTE_STRENGTH = 45*0.5
	)

	attribute_damage = list(
		ATTRIBUTE_STRENGTH = PIERCE
	)

	attack_delay = 12*0.5
	attack_delay_max = 12