/damagetype/melee/sword/mezzaluna
	name = "mezzaluna"

	//The base attack damage of the weapon. It's a flat value, unaffected by any skills or attributes.
	attack_damage_base = list(
		BLADE = 90*0.2,
		BLUNT = 90*0.1
	)

	//How much armor to penetrate. It basically removes the percentage of the armor using these values.
	attack_damage_penetration = list(
		BLADE = 100*0.5,
		BLUNT = 100*0.5
	)

	attribute_stats = list(
		ATTRIBUTE_STRENGTH = 90*0.5
	)

	attribute_damage = list(
		ATTRIBUTE_STRENGTH = BLADE
	)

	skill_stats = list(
		SKILL_MELEE = 90*0.2,
	)

	skill_damage = list(
		SKILL_MELEE = BLADE
	)

	attack_delay = 18*0.5
	attack_delay_max = 18