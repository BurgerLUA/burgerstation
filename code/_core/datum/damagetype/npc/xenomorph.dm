/damagetype/npc/xenomorph
	name = "Xenomorph Claw"
	id = "xenomorph"
	desc = "The claw of a xenomorph."
	attack_verbs = list("claw","scratch","maul")
	weapon_name = "claws"

	base_attack_damage = list(
		BRUTE = 15,
		BURN = 0,
		TOX = 0,
		OXY = 0
	)

	attribute_stats = list(
		ATTRIBUTE_STRENGTH = CLASS_B,
		ATTRIBUTE_AGILITY = CLASS_B,
		ATTRIBUTE_INTELLIGENCE = CLASS_F
	)

	attribute_damage = list(
		ATTRIBUTE_STRENGTH = BRUTE,
		ATTRIBUTE_AGILITY = BRUTE,
		ATTRIBUTE_INTELLIGENCE = BRUTE
	)

	skill_stats = list(
		SKILL_UNARMED = CLASS_B,
		SKILL_MELEE = CLASS_F,
		SKILL_RANGED = CLASS_F
	)

	skill_damage = list(
		SKILL_UNARMED = BRUTE,
		SKILL_MELEE = BRUTE,
		SKILL_RANGED = BRUTE
	)

	attack_delay = 2

/damagetype/npc/xenomorph/queen
	name = "Xenomorph Poisoned Claws"
	id = "xenomorph_queen"
	desc = "The claw of a xenomorph queen."
	attack_verbs = list("claw","scratch","maul")
	weapon_name = "poisonous claws"

	base_attack_damage = list(
		BRUTE = 40,
		BURN = 0,
		TOX = 10,
		OXY = 0
	)

	attribute_stats = list(
		ATTRIBUTE_STRENGTH = CLASS_A,
		ATTRIBUTE_AGILITY = CLASS_E,
		ATTRIBUTE_INTELLIGENCE = CLASS_F
	)

	attribute_damage = list(
		ATTRIBUTE_STRENGTH = BRUTE,
		ATTRIBUTE_AGILITY = BRUTE,
		ATTRIBUTE_INTELLIGENCE = BRUTE
	)

	skill_stats = list(
		SKILL_UNARMED = CLASS_B,
		SKILL_MELEE = CLASS_F,
		SKILL_RANGED = CLASS_F
	)

	skill_damage = list(
		SKILL_UNARMED = BRUTE,
		SKILL_MELEE = BRUTE,
		SKILL_RANGED = BRUTE
	)

	attack_delay = 20