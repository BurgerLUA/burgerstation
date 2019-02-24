//Fists
/damagetype/unarmed/fists/
	name = "Fist"
	id = "human_fist_right"
	desc = "Your fist."
	attack_verbs = list("punch","hit","slap","strike","pummel","pound")
	weapon_name = "right fist"

	attack_delay = 5

	base_attack_damage = list(
		BRUTE = 1,
		BURN = 0,
		TOX = 0,
		OXY = 0
	)

	attribute_stats = list(
		ATTRIBUTE_STRENGTH = CLASS_D,
		ATTRIBUTE_AGILITY = CLASS_D,
		ATTRIBUTE_INTELLIGENCE = CLASS_F
	)

	attribute_damage = list(
		ATTRIBUTE_STRENGTH = BRUTE,
		ATTRIBUTE_AGILITY = BRUTE,
		ATTRIBUTE_INTELLIGENCE = BRUTE
	)

	skill_stats = list(
		SKILL_UNARMED = CLASS_D,
		SKILL_MELEE = CLASS_F,
		SKILL_RANGED = CLASS_F
	)

	skill_damage = list(
		SKILL_UNARMED = BRUTE,
		SKILL_MELEE = BRUTE,
		SKILL_RANGED = BRUTE
	)

/damagetype/unarmed/fists/left
	weapon_name = "left fist"
	id = "human_fist_left"