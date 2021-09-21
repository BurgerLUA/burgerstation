/damagetype/melee/sword/handsword

	swing_sounds = list(
		'sound/weapons/handsword/swing.ogg'
	)
	impact_sounds = list(
		'sound/weapons/handsword/hit_01.ogg'
	)

	//The base attack damage of the weapon. It's a flat value, unaffected by any skills or attributes.
	attack_damage_base = list(
		BLADE = 20,
		LASER = 20
	)

	//How much armor to penetrate. It basically removes the percentage of the armor using these values.
	attack_damage_penetration = list(
		BLADE = 100,
		LASER = 100,
		HEAT = 100
	)

	attribute_stats = list(
		ATTRIBUTE_STRENGTH = 25,
		ATTRIBUTE_DEXTERITY = 40
	)

	attribute_damage = list(
		ATTRIBUTE_STRENGTH = list(BLADE,LASER),
		ATTRIBUTE_DEXTERITY = list(BLADE,LASER)
	)

	skill_stats = list(
		SKILL_MELEE = 40,
		SKILL_UNARMED = 30
	)

	skill_damage = list(
		SKILL_MELEE = list(BLADE,LASER),
		SKILL_UNARMED = list(BLADE,LASER)
	)

	attack_delay = 10
	attack_delay_max = 20