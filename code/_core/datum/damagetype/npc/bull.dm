/damagetype/npc/bull
	name = "Bull Gore"

	//The base attack damage of the weapon. It's a flat value, unaffected by any skills or attributes.
	attack_damage_base = list(
		BLUNT = 5,
		PIERCE = 15,
	)

	//How much armor to penetrate. It basically removes the percentage of the armor using these values.
	attack_damage_penetration = list(
		BLUNT = 50,
		PIERCE = 50,
	)


	attribute_stats = list(
		ATTRIBUTE_STRENGTH = 40
	)

	attribute_damage = list(
		ATTRIBUTE_STRENGTH = PIERCE
	)