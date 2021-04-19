/damagetype/melee/sword/rev_bayonet
	name = "bayonet"

	attack_damage_base = list(
		PIERCE = 30*0.4,
		BLADE = 30*0.1,
	)

	//How much armor to penetrate. It basically removes the percentage of the armor using these values.
	attack_damage_penetration = list(
		PIERCE = 20*0.75,
		BLADE = 20**0.25,
	)

	attribute_stats = list(
		ATTRIBUTE_STRENGTH = 30*0.1,
		ATTRIBUTE_DEXTERITY = 30*0.2,
	)

	attribute_damage = list(
		ATTRIBUTE_STRENGTH = PIERCE,
		ATTRIBUTE_DEXTERITY = PIERCE
	)

	skill_stats = list(
		SKILL_MELEE = 30*0.2
	)

	skill_damage = list(
		SKILL_MELEE = PIERCE
	)

	attack_delay = 10*0.5
	attack_delay_max = 10