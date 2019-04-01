/damagetype/ranged/bullet/
	name = "bullet"
	id = null

	base_attack_damage = list(
		BRUTE = 0,
		BURN = 0,
		TOX = 0,
		OXY = 0
	)

	attribute_stats = list(
		ATTRIBUTE_STRENGTH = CLASS_F,
		ATTRIBUTE_AGILITY = CLASS_F,
		ATTRIBUTE_INTELLIGENCE = CLASS_F
	)

	attribute_damage = list(
		ATTRIBUTE_STRENGTH = BRUTE,
		ATTRIBUTE_AGILITY = BRUTE,
		ATTRIBUTE_INTELLIGENCE = BRUTE
	)

	skill_stats = list(
		SKILL_UNARMED = CLASS_F,
		SKILL_MELEE = CLASS_F,
		SKILL_RANGED = CLASS_F
	)

	skill_damage = list(
		SKILL_UNARMED = BRUTE,
		SKILL_MELEE = BRUTE,
		SKILL_RANGED = BRUTE
	)

	skill_xp_per_damage = list(
		SKILL_UNARMED = 0,
		SKILL_MELEE = 0,
		SKILL_RANGED = 0.5
	)

/damagetype/ranged/bullet/bolt
	name = "metal bolt"
	id = "bolt_metal"

	base_attack_damage = list(
		BRUTE = 20,
		BURN = 0,
		TOX = 0,
		OXY = 0
	)

/damagetype/ranged/bullet/revolver_38
	name = ".38 bullet"
	id = "38"

	base_attack_damage = list(
		BRUTE = 15,
		BURN = 0,
		TOX = 0,
		OXY = 0
	)