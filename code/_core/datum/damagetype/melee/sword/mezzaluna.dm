/damagetype/melee/sword/mezzaluna
	name = "mezzaluna"

	//The base attack damage of the weapon. It's a flat value, unaffected by any skills or attributes.
	attack_damage_base = list(
		BLADE = 70,
		BLUNT = 20
	)

	//How much armor to penetrate. It basically removes the percentage of the armor using these values.
	attack_damage_penetration = list(
		BLADE = 45,
		BLUNT = 20
	)

	attribute_stats = list(
		ATTRIBUTE_STRENGTH = 80
	)

	attribute_damage = list(
		ATTRIBUTE_STRENGTH = BLADE
	)

	skill_stats = list(
		SKILL_MELEE = 60,
	)

	skill_damage = list(
		SKILL_MELEE = BLADE
	)
