/damagetype/sword/
	name = "sword"
	desc = "Live and die by it."
	impact_sounds = list(
		'sounds/effects/impacts/bladeslice.ogg',
	)
	miss_sounds = list(
		'sounds/effects/impacts/punchmiss.ogg'
	)


/damagetype/sword/sabre
	name = "sabre"

	base_attack_damage = list(
		BRUTE = 50,
		BURN = 0,
		TOX = 0,
		OXY = 0
	)

	attribute_stats = list(
		ATTRIBUTE_STRENGTH = CLASS_D,
		ATTRIBUTE_AGILITY = CLASS_C,
		ATTRIBUTE_INTELLIGENCE = CLASS_F
	)

	attribute_damage = list(
		ATTRIBUTE_STRENGTH = BRUTE,
		ATTRIBUTE_AGILITY = BRUTE,
		ATTRIBUTE_INTELLIGENCE = BRUTE
	)

	skill_stats = list(
		SKILL_UNARMED = CLASS_F,
		SKILL_MELEE = CLASS_C,
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

/damagetype/sword/energy
	name = "energy sword"

	impact_sounds = list('sounds/weapon/melee/saberhit.ogg')

	base_attack_damage = list(
		BRUTE = 10,
		BURN = 50,
		TOX = 0,
		OXY = 0
	)

	attribute_stats = list(
		ATTRIBUTE_STRENGTH = CLASS_E,
		ATTRIBUTE_AGILITY = CLASS_B,
		ATTRIBUTE_INTELLIGENCE = CLASS_F
	)

	attribute_damage = list(
		ATTRIBUTE_STRENGTH = BURN,
		ATTRIBUTE_AGILITY = BURN,
		ATTRIBUTE_INTELLIGENCE = BURN
	)

	skill_stats = list(
		SKILL_UNARMED = CLASS_F,
		SKILL_MELEE = CLASS_B,
		SKILL_RANGED = CLASS_F
	)

	skill_damage = list(
		SKILL_UNARMED = BURN,
		SKILL_MELEE = BURN,
		SKILL_RANGED = BURN
	)

	skill_xp_per_damage = list(
		SKILL_UNARMED = 0,
		SKILL_MELEE = 1,
		SKILL_RANGED = 0
	)

/damagetype/shield/energy
	name = "energy shield"

	impact_sounds = list('sounds/weapon/melee/saberon.ogg')

	base_attack_damage = list(
		BRUTE = 25,
		BURN = 0,
		TOX = 0,
		OXY = 0
	)

	attribute_stats = list(
		ATTRIBUTE_STRENGTH = CLASS_E,
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