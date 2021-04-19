/damagetype/melee/sword/zweihander
	name = "zweihander"

	//The base attack damage of the weapon. It's a flat value, unaffected by any skills or attributes.
	attack_damage_base = list(
		BLADE = 75*0.1
	)

	//How much armor to penetrate. It basically removes the percentage of the armor using these values.
	attack_damage_penetration = list(
		BLADE = 80
	)

	attribute_stats = list(
		ATTRIBUTE_STRENGTH = 75*0.6,
		ATTRIBUTE_DEXTERITY = 75*0.2
	)

	attribute_damage = list(
		ATTRIBUTE_STRENGTH = BLADE,
		ATTRIBUTE_DEXTERITY = BLADE
	)

	skill_stats = list(
		SKILL_MELEE = 75*0.1,
	)

	skill_damage = list(
		SKILL_MELEE = BLADE
	)

	attack_delay = 16*0.5
	attack_delay_max = 16