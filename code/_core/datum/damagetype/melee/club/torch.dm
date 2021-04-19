/damagetype/melee/club/torch/
	name = "torch"

	//The base attack damage of the weapon. It's a flat value, unaffected by any skills or attributes.
	attack_damage_base = list(
		BLUNT = 45*0.2,
	)

	//How much armor to penetrate. It basically removes the percentage of the armor using these values.
	attack_damage_penetration = list(
		BLUNT = 40
	)

	attribute_stats = list(
		ATTRIBUTE_STRENGTH = 45*0.7
	)

	attribute_damage = list(
		ATTRIBUTE_STRENGTH = BLUNT
	)

	skill_stats = list(
		SKILL_MELEE = 45*0.1
	)

	skill_damage = list(
		SKILL_MELEE = BLUNT,
	)

	attack_delay = 12*0.5
	attack_delay_max = 12

/damagetype/melee/club/torch/on
	name = "torch"

	//The base attack damage of the weapon. It's a flat value, unaffected by any skills or attributes.
	attack_damage_base = list(
		BLUNT = 45*0.1,
		HEAT = 45*0.5
	)

	//How much armor to penetrate. It basically removes the percentage of the armor using these values.
	attack_damage_penetration = list(
		BLUNT = 40*0.5,
		HEAT = 40*0.5
	)

	attribute_stats = list(
		ATTRIBUTE_STRENGTH = 45*0.2
	)

	attribute_damage = list(
		ATTRIBUTE_STRENGTH = BLUNT
	)

	skill_stats = list(
		SKILL_MELEE = 45*0.1
	)

	skill_damage = list(
		SKILL_MELEE = BLUNT,
	)

	attack_delay = 12*0.5
	attack_delay_max = 12