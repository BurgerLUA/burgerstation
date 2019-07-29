/damagetype/sword/
	name = "sword"
	desc = "Live and die by it."

	impact_sounds = list(
		'sounds/weapons/blade/hit_light.ogg',
	)
	miss_sounds = list(
		'sounds/weapons/fists/punchmiss.ogg'
	)

	draw_blood = TRUE

/damagetype/sword/sabre
	name = "sabre"
	id = "sword_sabre"

	base_attack_damage = list(
		BRUTE = 40,
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
