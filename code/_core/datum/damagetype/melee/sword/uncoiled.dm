/damagetype/melee/sword/uncoiled
	name = "uncoiled sword"

	//The base attack damage of the weapon. It's a flat value, unaffected by any skills or attributes.
	attack_damage_base = list(
		BLADE = 30*0.2,
		PIERCE = 30*0.1
	)

	//How much armor to penetrate. It basically removes the percentage of the armor using these values.
	attack_damage_penetration = list(
		BLADE = 20*0.5,
		PIERCE = 20*0.5
	)

	attribute_stats = list(
		ATTRIBUTE_STRENGTH = 30*0.1,
		ATTRIBUTE_DEXTERITY = 30*0.3
	)

	attribute_damage = list(
		ATTRIBUTE_STRENGTH = list(BLADE,PIERCE),
		ATTRIBUTE_DEXTERITY = list(BLADE,PIERCE)
	)

	skill_stats = list(
		SKILL_MELEE = 30*0.3
	)

	skill_damage = list(
		SKILL_MELEE = list(BLADE,PIERCE)
	)

	attack_delay = 10*0.5
	attack_delay_max = 10