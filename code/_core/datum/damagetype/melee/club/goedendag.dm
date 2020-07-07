/damagetype/melee/club/goedendag
	name = "goedendag"

	//The base attack damage of the weapon. It's a flat value, unaffected by any skills or attributes.
	attack_damage_base = list(
		BLUNT = 75,
		PIERCE = 25
	)

	//How much armor to penetrate. It basically removes the percentage of the armor using these values.
	attack_damage_penetration = list(
		BLUNT = 65,
		PIERCE = 20
	)

	attribute_stats = list(
		ATTRIBUTE_STRENGTH = 85
	)

	attribute_damage = list(
		ATTRIBUTE_STRENGTH = BLUNT,
		ATTRIBUTE_STRENGTH = PIERCE
	)

	skill_stats = list(
		SKILL_MELEE = 50
	)

	skill_damage = list(
		SKILL_MELEE = BLUNT
	)