/damagetype/melee/club/shield
	name = "shield"
	id = "shield_wood"

	base_attack_damage = list(
		BRUTE = 5,
		BURN = 0,
		TOX = 0,
		OXY = 0
	)

	attribute_stats = list(
		ATTRIBUTE_STRENGTH = CLASS_D,
		ATTRIBUTE_AGILITY = CLASS_E
	)

	attribute_damage = list(
		ATTRIBUTE_STRENGTH = BRUTE,
		ATTRIBUTE_AGILITY = BRUTE
	)

	skill_stats = list(
		SKILL_BLOCK = CLASS_D,
		SKILL_MELEE = CLASS_E
	)

	skill_damage = list(
		SKILL_MELEE = BRUTE,
		SKILL_BLOCK = BRUTE,
	)

	skill_xp_per_damage = list(
		SKILL_MELEE = 1,
	)

/damagetype/melee/club/shield/energy
	name = "energy shield"
	id = "shield_energy"

	//impact_sounds = list('sounds/weapon/melee/saberon.ogg')

	base_attack_damage = list(
		BRUTE = 30,
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
		SKILL_MELEE = 1,
		SKILL_RANGED = 0
	)

