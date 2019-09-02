/damagetype/template/
	name = "template"
	id = null

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
		FATIGUE = 0
	)

	//The damage conversion table of the weapon. Useful for when you have blades that are unholy or something.
	attack_damage_conversion = list(
		BLADE = BRUTE,
		BLUNT = BRUTE,
		PIERCE = BRUTE,
		LASER = BURN,
		MAGIC = BURN,
		HEAT = BURN,
		COLD = BURN,
		BOMB = BRUTE,
		BIO = TOX,
		RAD = TOX,
		HOLY = BURN,
		DARK = BURN,
		FATIGUE = OXY
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
		FATIGUE = 0
	)


	attribute_stats = list(
		ATTRIBUTE_STRENGTH = CLASS_F,
		ATTRIBUTE_AGILITY = CLASS_F,
		ATTRIBUTE_INTELLIGENCE = CLASS_F
	)

	attribute_damage = list(
		ATTRIBUTE_STRENGTH = BLADE,
		ATTRIBUTE_AGILITY = BLADE,
		ATTRIBUTE_INTELLIGENCE = BLADE
	)

	skill_stats = list(
		SKILL_UNARMED = CLASS_F,
		SKILL_MELEE = CLASS_F,
		SKILL_RANGED = CLASS_F
	)

	skill_damage = list(
		SKILL_UNARMED = BLADE,
		SKILL_MELEE = BLADE,
		SKILL_RANGED = BLADE
	)

	skill_xp_per_damage = list(
		SKILL_UNARMED = 0,
		SKILL_MELEE = 0,
		SKILL_RANGED = 0
	)