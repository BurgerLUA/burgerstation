/damagetype/melee/sword/skana
	name = "skana"

	//The base attack damage of the weapon. It's a flat value, unaffected by any skills or attributes.
	attack_damage_base = list(
		BLADE = 30*0.4,
		PIERCE = 30*0.05,
		BLUNT = 30*0.05
	)

	//How much armor to penetrate. It basically removes the percentage of the armor using these values.
	attack_damage_penetration = list(
		BLADE = 20*0.8,
		PIERCE = 20*0.1,
		BLUNT = 20*0.1
	)

	attribute_stats = list(
		ATTRIBUTE_DEXTERITY = 30*0.3
	)

	attribute_damage = list(
		ATTRIBUTE_DEXTERITY = BLADE
	)

	skill_stats = list(
		SKILL_MELEE = 30*0.2
	)

	skill_damage = list(
		SKILL_MELEE = BLADE
	)

	attack_delay = 10*0.5
	attack_delay_max = 10