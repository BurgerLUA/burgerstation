/damagetype/ranged/magic/fireball
	name = "fire ball"
	id = "magic_fireball"

	base_attack_damage = list(
		BRUTE = 0,
		BURN = 100,
		TOX = 0,
		OXY = 0
	)

	attribute_stats = list(
		ATTRIBUTE_STRENGTH = CLASS_F,
		ATTRIBUTE_AGILITY = CLASS_F,
		ATTRIBUTE_INTELLIGENCE = CLASS_B
	)

	attribute_damage = list(
		ATTRIBUTE_STRENGTH = BURN,
		ATTRIBUTE_AGILITY = BURN,
		ATTRIBUTE_INTELLIGENCE = BURN
	)

	skill_stats = list(
		SKILL_UNARMED = CLASS_F,
		SKILL_MELEE = CLASS_F,
		SKILL_RANGED = CLASS_F
	)

	skill_damage = list(
		SKILL_UNARMED = BURN,
		SKILL_MELEE = BURN,
		SKILL_RANGED = BURN
	)

	skill_xp_per_damage = list(
		SKILL_UNARMED = 0,
		SKILL_MELEE = 0,
		SKILL_RANGED = 0
	)

/damagetype/ranged/magic/chaos
	name = "chaos ball"
	id = "magic_chaosball"

	base_attack_damage = list(
		BRUTE = 0,
		BURN = 75,
		TOX = 0,
		OXY = 0
	)

	attribute_stats = list(
		ATTRIBUTE_STRENGTH = CLASS_D,
		ATTRIBUTE_AGILITY = CLASS_D,
		ATTRIBUTE_INTELLIGENCE = CLASS_D
	)

	attribute_damage = list(
		ATTRIBUTE_STRENGTH = BURN,
		ATTRIBUTE_AGILITY = BURN,
		ATTRIBUTE_INTELLIGENCE = BURN
	)

	skill_stats = list(
		SKILL_UNARMED = CLASS_F,
		SKILL_MELEE = CLASS_F,
		SKILL_RANGED = CLASS_F
	)

	skill_damage = list(
		SKILL_UNARMED = BURN,
		SKILL_MELEE = BURN,
		SKILL_RANGED = BURN
	)

	skill_xp_per_damage = list(
		SKILL_UNARMED = 0,
		SKILL_MELEE = 0,
		SKILL_RANGED = 0
	)

/damagetype/ranged/magic/magic_missile
	name = "magic missle"
	id = "magic_missile"

	base_attack_damage = list(
		BRUTE = 5,
		BURN = 5,
		TOX = 0,
		OXY = 0
	)

	attribute_stats = list(
		ATTRIBUTE_STRENGTH = CLASS_F,
		ATTRIBUTE_AGILITY = CLASS_F,
		ATTRIBUTE_INTELLIGENCE = CLASS_B
	)

	attribute_damage = list(
		ATTRIBUTE_STRENGTH = BURN,
		ATTRIBUTE_AGILITY = BURN,
		ATTRIBUTE_INTELLIGENCE = BURN
	)

	skill_stats = list(
		SKILL_UNARMED = CLASS_F,
		SKILL_MELEE = CLASS_F,
		SKILL_RANGED = CLASS_F
	)

	skill_damage = list(
		SKILL_UNARMED = BURN,
		SKILL_MELEE = BURN,
		SKILL_RANGED = BURN
	)

	skill_xp_per_damage = list(
		SKILL_UNARMED = 0,
		SKILL_MELEE = 0,
		SKILL_RANGED = 0
	)

/damagetype/ranged/magic/lightning
	name = "lightning"
	id = "magic_lightning"

	impact_sounds = list('sounds/weapons/magic/zap_large.ogg')

	base_attack_damage = list(
		BRUTE = 0,
		BURN = 5,
		TOX = 0,
		OXY = 0
	)

	attribute_stats = list()

	attribute_damage = list()

	skill_stats = list(
		SKILL_PRAYER = CLASS_A
	)

	skill_damage = list(
		SKILL_PRAYER = BURN
	)

	skill_xp_per_damage = list(
		SKILL_PRAYER = 1
	)