/damagetype/melee/sword/gladius
	name = "gladius"

	//The base attack damage of the weapon. It's a flat value, unaffected by any skills or attributes.
	attack_damage_base = list(
		BLADE = 15*0.3,
		PIERCE = 15*0.2
	)

	//How much armor to penetrate. It basically removes the percentage of the armor using these values.
	attack_damage_penetration = list(
		BLADE = 10*0.5,
		PIERCE = 10*0.5
	)

	attribute_stats = list(
		ATTRIBUTE_STRENGTH = 15*0.1,
		ATTRIBUTE_DEXTERITY = 15*0.2
	)

	attribute_damage = list(
		ATTRIBUTE_STRENGTH = BLADE,
		ATTRIBUTE_DEXTERITY = PIERCE
	)

	skill_stats = list(
		SKILL_MELEE = 15*0.2
	)

	skill_damage = list(
		SKILL_MELEE = BLADE
	)

	attack_delay = 8*0.5
	attack_delay_max = 8