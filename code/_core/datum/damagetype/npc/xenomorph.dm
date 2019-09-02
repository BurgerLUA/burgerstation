/damagetype/npc/xenomorph
	name = "Xenomorph Claw"
	id = "xenomorph"
	desc = "The claw of a xenomorph."
	attack_verbs = list("claw","scratch","maul")
	weapon_name = "claws"


	//The base attack damage of the weapon. It's a flat value, unaffected by any skills or attributes.
	attack_damage_base = list(
		BLADE = 25,
		BLUNT = 5,
		PIERCE = 25,
		FATIGUE = 30
	)

	//The damage conversion table of the weapon. Useful for when you want blade attacks to deal holy damage or something.
	attack_damage_conversion = list(
		BLADE = BRUTE,
		BLUNT = BRUTE,
		FATIGUE = OXY
	)

	//How much armor to penetrate. It basically removes the percentage of the armor using these values.
	attack_damage_penetration = list(
		BLADE = 50,
		BLUNT = 50,
		PIERCE = 75,
		FATIGUE = 10
	)

	attribute_stats = list(
		ATTRIBUTE_STRENGTH = CLASS_B,
		ATTRIBUTE_DEXTERITY = CLASS_A
	)

	attribute_damage = list(
		ATTRIBUTE_STRENGTH = BLADE,
		ATTRIBUTE_DEXTERITY = PIERCE
	)

	skill_stats = list(
		SKILL_UNARMED = CLASS_D
	)

	skill_damage = list(
		SKILL_UNARMED = FATIGUE
	)

	skill_xp_per_damage = list()

/damagetype/npc/xenomorph/queen
	name = "Xenomorph Poisoned Claws"
	id = "xenomorph_queen"
	desc = "The claw of a xenomorph queen."
	attack_verbs = list("claw","scratch","maul")
	weapon_name = "poisonous claws"


	//The base attack damage of the weapon. It's a flat value, unaffected by any skills or attributes.
	attack_damage_base = list(
		BLADE = 30,
		BLUNT = 10,
		PIERCE = 20
	)

	//The damage conversion table of the weapon. Useful for when you want blade attacks to deal holy damage or something.
	attack_damage_conversion = list(
		BLADE = BRUTE,
		BLUNT = BRUTE,
		PIERCE = BRUTE
	)

	//How much armor to penetrate. It basically removes the percentage of the armor using these values.
	attack_damage_penetration = list(
		BLADE = 75,
		BLUNT = 75,
		PIERCE = 75
	)

	attribute_stats = list(
		ATTRIBUTE_STRENGTH = CLASS_S,
		ATTRIBUTE_DEXTERITY = CLASS_E
	)

	attribute_damage = list(
		ATTRIBUTE_STRENGTH = BLADE,
		ATTRIBUTE_DEXTERITY = PIERCE
	)

	skill_stats = list(
		SKILL_UNARMED = CLASS_D,
	)

	skill_damage = list(
		SKILL_UNARMED = BLUNT
	)

	skill_xp_per_damage = list()