/damagetype/melee/club/gold_toolbox
	name = "gold toolbox"

	//The base attack damage of the weapon. It's a flat value, unaffected by any skills or attributes.
	attack_damage_base = list(
		BLUNT = 50,
		FATIGUE = 10
	)

	//How much armor to penetrate. It basically removes the percentage of the armor using these values.
	attack_damage_penetration = list(
		BLUNT = 20,
		FATIGUE = 5
	)

	attribute_stats = list(
		ATTRIBUTE_STRENGTH = 20*0.3,
		ATTRIBUTE_DEXTERITY = 10
	)

	attribute_damage = list(
		ATTRIBUTE_STRENGTH = BLUNT,
		ATTRIBUTE_DEXTERITY = BLUNT
	)

	skill_stats = list(
		SKILL_MELEE = 55*0.5,
	)

	skill_damage = list(
		SKILL_MELEE = BLUNT,
	)

	attack_delay = 10
	attack_delay_max = 10