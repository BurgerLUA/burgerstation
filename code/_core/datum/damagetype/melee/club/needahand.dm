/damagetype/melee/club/needahand/

	//The base attack damage of the weapon. It's a flat value, unaffected by any skills or attributes.
	attack_damage_base = list(
		BLUNT = 10,
		SANITY = 25
	)

	//How much armor to penetrate. It basically removes the percentage of the armor using these values.
	attack_damage_penetration = list(
		BLUNT = 10,
		SANITY = 20
	)

	attribute_stats = list(
		ATTRIBUTE_STRENGTH = 15,
		ATTRIBUTE_WILLPOWER = 30
	)

	attribute_damage = list(
		ATTRIBUTE_STRENGTH = BLUNT,
		ATTRIBUTE_WILLPOWER = SANITY
	)

	skill_stats = list(
		SKILL_MELEE = 15
	)

	skill_damage = list(
		SKILL_MELEE = BLUNT
	)

	attack_delay = 15
	attack_delay_max = 22

	impact_sounds = list(
		'sound/weapons/unarmed/heavy_punch_06.ogg',
	)