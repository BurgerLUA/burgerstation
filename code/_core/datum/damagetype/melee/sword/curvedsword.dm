/damagetype/melee/sword/curvedsword
	name = "steel curved sword"

	//The base attack damage of the weapon. It's a flat value, unaffected by any skills or attributes.
	attack_damage_base = list(
		BLADE = 45*0.2
	)

	//How much armor to penetrate. It basically removes the percentage of the armor using these values.
	attack_damage_penetration = list(
		BLADE = 40
	)

	attribute_stats = list(
		ATTRIBUTE_STRENGTH = 45*0.2,
		ATTRIBUTE_DEXTERITY = 45*0.3
	)

	attribute_damage = list(
		ATTRIBUTE_STRENGTH = BLADE,
		ATTRIBUTE_DEXTERITY = BLADE
	)

	skill_stats = list(
		SKILL_MELEE = 45*0.3
	)

	skill_damage = list(
		SKILL_MELEE = BLADE
	)

	attack_delay = 12*0.5
	attack_delay_max = 12