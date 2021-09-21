/damagetype/melee/club/flagpole
	name = "Old Glory"

	//The base attack damage of the weapon. It's a flat value, unaffected by any skills or attributes.
	attack_damage_base = list(
		BLUNT = 40*0.4,
		PIERCE = 15*0.2
	)

	//How much armor to penetrate. It basically removes the percentage of the armor using these values.
	attack_damage_penetration = list(
		BLUNT = 75,
		PIERCE = 75
	)

	attribute_stats = list(
		ATTRIBUTE_STRENGTH = 50*0.5
	)

	attribute_damage = list(
		ATTRIBUTE_STRENGTH = list(BLUNT,PIERCE)
	)

	skill_stats = list(
		SKILL_MELEE = 40*0.5
	)

	skill_damage = list(
		SKILL_MELEE = BLUNT
	)

	attack_delay = 10
	attack_delay_max = 15