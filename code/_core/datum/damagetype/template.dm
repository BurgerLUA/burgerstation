/damagetype/template/
	name = "template"

	//The base attack damage of the weapon. It's a flat value, unaffected by any skills or attributes.
	attack_damage_base = list(
		BLADE = 0,
		BLUNT = 0,
		PIERCE = 0,
		LASER = 0,
		MAGIC = 0,
		HEAT = 0,
		COLD = 0,
		BOMB = 0,
		BIO = 0,
		RAD = 0,
		HOLY = 0,
		DARK = 0,
		FATIGUE = 0,
		ION = 0,
		PAIN = 0
	)

	//How much armor to penetrate. It basically removes the percentage of the armor using these values.
	attack_damage_penetration = list(
		BLADE = 0,
		BLUNT = 0,
		PIERCE = 0,
		LASER = 0,
		MAGIC = 0,
		HEAT = 0,
		COLD = 0,
		BOMB = 0,
		BIO = 0,
		RAD = 0,
		HOLY = 0,
		DARK = 0,
		FATIGUE = 0,
		ION = 0,
		PAIN = 0
	)


	attribute_stats = list(
		ATTRIBUTE_STRENGTH = 100,
		ATTRIBUTE_DEXTERITY = 100,
		ATTRIBUTE_INTELLIGENCE = 100
	)

	attribute_damage = list(
		ATTRIBUTE_STRENGTH = BLADE,
		ATTRIBUTE_DEXTERITY = BLADE,
		ATTRIBUTE_INTELLIGENCE = BLADE
	)

	skill_stats = list(
		SKILL_UNARMED = 100,
		SKILL_MELEE = 100,
		SKILL_RANGED = 100
	)

	skill_damage = list(
		SKILL_UNARMED = BLADE,
		SKILL_MELEE = BLADE,
		SKILL_RANGED = BLADE
	)