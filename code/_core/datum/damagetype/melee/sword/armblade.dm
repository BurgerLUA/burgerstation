/damagetype/melee/sword/armblade
	name = "fleshblade"

	//The base attack damage of the weapon. It's a flat value, unaffected by any skills or attributes.
	attack_damage_base = list(
		BLADE = 45*0.2,
		PIERCE = 45*0.1,
		BIO = 45*0.2
	)

	//How much armor to penetrate. It basically removes the percentage of the armor using these values.
	attack_damage_penetration = list(
		BLADE = 40*0.5,
		PIERCE = 40*0.25,
		BIO = 40*0.25
	)

	attribute_stats = list(
		ATTRIBUTE_STRENGTH = 45*0.3,
		ATTRIBUTE_DEXTERITY = 45*0.1
	)

	attribute_damage = list(
		ATTRIBUTE_STRENGTH = list(BLADE,PIERCE),
		ATTRIBUTE_DEXTERITY = list(BLADE,PIERCE)
	)

	skill_stats = list(
		SKILL_MELEE = 45*0.1,
	)

	skill_damage = list(
		SKILL_MELEE = list(BLADE,PIERCE)
	)

	attack_delay = 12*0.5
	attack_delay_max = 12