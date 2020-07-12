/damagetype/melee/club/mace/
	name = "mace"

	//The base attack damage of the weapon. It's a flat value, unaffected by any skills or attributes.
	attack_damage_base = list(
		BLUNT = 25,
		PIERCE = 5
	)

	//How much armor to penetrate. It basically removes the percentage of the armor using these values.
	attack_damage_penetration = list(
		BLUNT = 40,
		PIERCE = 5
	)

	attribute_stats = list(
		ATTRIBUTE_STRENGTH = 40
	)

	attribute_damage = list(
		ATTRIBUTE_STRENGTH = BLUNT
	)

	skill_stats = list(
		SKILL_MELEE = 25
	)

	skill_damage = list(
		SKILL_MELEE = BLUNT
	)