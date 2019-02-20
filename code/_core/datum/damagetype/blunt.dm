/damagetype/blunt/
	name = "blunt object"
	id = "blunt"
	desc = "Live and die by it."
	impact_sounds = list(
		'sounds/effects/impacts/punch1.ogg',
		'sounds/effects/impacts/punch2.ogg',
		'sounds/effects/impacts/punch3.ogg',
		'sounds/effects/impacts/punch4.ogg'
	)
	miss_sounds = list(
		'sounds/effects/impacts/punchmiss.ogg'
	)

/damagetype/blunt/pistol
	name = "pistol grip"

	base_attack_damage = list(
		BRUTE = 5,
		BURN = 0,
		TOX = 0,
		OXY = 0
	)

	attribute_stats = list(
		ATTRIBUTE_STRENGTH = CLASS_E,
		ATTRIBUTE_AGILITY = CLASS_E,
		ATTRIBUTE_INTELLIGENCE = CLASS_F
	)

	attribute_damage = list(
		ATTRIBUTE_STRENGTH = BRUTE,
		ATTRIBUTE_AGILITY = BRUTE,
		ATTRIBUTE_INTELLIGENCE = BRUTE
	)

	skill_stats = list(
		SKILL_UNARMED = CLASS_F,
		SKILL_MELEE = CLASS_E,
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

/damagetype/blunt/toolbox
	name = "toolbox"
	id = "toolbox"

	base_attack_damage = list(
		BRUTE = 0,
		BURN = 0,
		TOX = 0,
		OXY = 0
	)

	attribute_stats = list(
		ATTRIBUTE_STRENGTH = CLASS_A,
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
		SKILL_MELEE = CLASS_E,
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

/damagetype/blunt/shield
	name = "shield"
	id = "shield"

	impact_sounds = list(
		'sounds/effects/impacts/punch1.ogg',
		'sounds/effects/impacts/punch2.ogg',
		'sounds/effects/impacts/punch3.ogg',
		'sounds/effects/impacts/punch4.ogg'
	)

	base_attack_damage = list(
		BRUTE = 20,
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