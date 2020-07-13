/damagetype/melee/sword/grazer
	name = "inactive grazer"

	attack_damage_base = list(
		BLADE = 20,
		PIERCE = 10,
	)

	//How much armor to penetrate. It basically removes the percentage of the armor using these values.
	attack_damage_penetration = list(
		BLADE = 50,
		PIERCE = 50,
	)

	attribute_stats = list(
		ATTRIBUTE_STRENGTH = 20,
		ATTRIBUTE_DEXTERITY = 30,
	)

	attribute_damage = list(
		ATTRIBUTE_STRENGTH = list(BLADE,PIERCE),
		ATTRIBUTE_DEXTERITY = list(BLADE,PIERCE)
	)

	skill_stats = list(
		SKILL_MELEE = 25
	)

	skill_damage = list(
		SKILL_MELEE = list(BLADE,PIERCE)
	)

/damagetype/melee/sword/grazer/on
	name = "active grazer"

	attack_damage_base = list(
		LASER = 20,
		HEAT = 10,
	)

	//How much armor to penetrate. It basically removes the percentage of the armor using these values.
	attack_damage_penetration = list(
		LASER = 75,
		HEAT = 75,
	)

	attribute_stats = list(
		ATTRIBUTE_STRENGTH = 20,
		ATTRIBUTE_DEXTERITY = 30,
	)

	attribute_damage = list(
		ATTRIBUTE_STRENGTH = list(LASER,HEAT),
		ATTRIBUTE_DEXTERITY = list(LASER,HEAT)
	)

	skill_stats = list(
		SKILL_MELEE = 25
	)

	skill_damage = list(
		SKILL_MELEE = list(LASER,HEAT)
	)