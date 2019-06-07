/damagetype/npc/slime
	name = "Slime Pounce"
	id = "slime_pounce"
	desc = "The pounce of a slime"
	attack_verbs = list("blob","pounce","absorb","slime")
	weapon_name = "slime"

	base_attack_damage = list(
		BRUTE = 0,
		BURN = 0,
		TOX = 1,
		OXY = 0
	)

	attribute_stats = list(
		ATTRIBUTE_STRENGTH = CLASS_D,
		ATTRIBUTE_AGILITY = CLASS_D,
		ATTRIBUTE_INTELLIGENCE = CLASS_D
	)

	attribute_damage = list(
		ATTRIBUTE_STRENGTH = TOX,
		ATTRIBUTE_AGILITY = TOX,
		ATTRIBUTE_INTELLIGENCE = TOX
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

	attack_delay = 5