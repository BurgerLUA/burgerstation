/damagetype/melee/sword/runic

	//The base attack damage of the weapon. It's a flat value, unaffected by any skills or attributes.
	attack_damage_base = list(
		BLADE = 30,
		PIERCE = 10,
	)

	//How much armor to penetrate. It basically removes the percentage of the armor using these values.
	attack_damage_penetration = list(
		BLADE = 25,
		PIERCE = 25
	)

	attribute_stats = list(
		ATTRIBUTE_STRENGTH = 70,
		ATTRIBUTE_DEXTERITY = 30,
	)

	attribute_damage = list(
		ATTRIBUTE_STRENGTH = list(BLADE,PIERCE),
		ATTRIBUTE_DEXTERITY = list(BLADE,PIERCE)
	)

	skill_stats = list(
		SKILL_MELEE = 75
	)

	skill_damage = list(
		SKILL_MELEE = list(BLADE,PIERCE)
	)

	attack_delay = 28
	attack_delay_max = 28

	impact_sounds = list(
		'sound/weapons/melee/runic/swing.ogg'
	)