/damagetype/melee/sword/soldiersword
	name = "soldier's sword"

	//The base attack damage of the weapon. It's a flat value, unaffected by any skills or attributes.
	attack_damage_base = list(
		BLADE = 10,
		BLUNT = 10
	)

	//How much armor to penetrate. It basically removes the percentage of the armor using these values.
	attack_damage_penetration = list(
		BLADE = 90,
		BLUNT = 70
	)

	attribute_stats = list(
		ATTRIBUTE_STRENGTH = 160,
		ATTRIBUTE_DEXTERITY = 30
	)

	attribute_damage = list(
		ATTRIBUTE_STRENGTH = BLADE,
		ATTRIBUTE_DEXTERITY = BLADE
	)

	skill_stats = list(
		SKILL_MELEE = 90
	)

	skill_damage = list(
		SKILL_MELEE = BLADE
	)