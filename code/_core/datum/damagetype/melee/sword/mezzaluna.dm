/damagetype/melee/sword/mezzaluna
	name = "mezzaluna"

	//The base attack damage of the weapon. It's a flat value, unaffected by any skills or attributes.
	attack_damage_base = list(
		BLADE = 30,
		BLUNT = 10
	)

	//How much armor to penetrate. It basically removes the percentage of the armor using these values.
	attack_damage_penetration = list(
		BLADE = 100,
		BLUNT = 100
	)

	attribute_stats = list(
		ATTRIBUTE_STRENGTH = 100
	)

	attribute_damage = list(
		ATTRIBUTE_STRENGTH = BLADE
	)

	skill_stats = list(
		SKILL_MELEE = 50,
	)

	skill_damage = list(
		SKILL_MELEE = BLADE
	)

	attack_delay = 20
	attack_delay_max = 30