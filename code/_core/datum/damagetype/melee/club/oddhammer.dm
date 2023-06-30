/damagetype/melee/club/oddhammer/

	//The base attack damage of the weapon. It's a flat value, unaffected by any skills or attributes.
	attack_damage_base = list(
		BLUNT = 5,
		SANITY = 30
	)

	//How much armor to penetrate. It basically removes the percentage of the armor using these values.
	attack_damage_penetration = list(
		BLUNT = 0,
		SANITY = 40
	)

	attribute_stats = list(
		ATTRIBUTE_STRENGTH = 20,
		ATTRIBUTE_WILLPOWER = 20
	)

	attribute_damage = list(
		ATTRIBUTE_STRENGTH = BLUNT,
		ATTRIBUTE_WILLPOWER = SANITY
	)

	skill_stats = list(
		SKILL_MELEE = 40
	)

	skill_damage = list(
		SKILL_MELEE = BLUNT
	)

	attack_delay = 10
	attack_delay_max = 15

	swing_sounds = list(
		'sound/weapons/unarmed/slap.ogg'
	)