/damagetype/blunt/
	name = "blunt object"
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