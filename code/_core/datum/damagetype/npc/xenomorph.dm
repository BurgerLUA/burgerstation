/damagetype/npc/xenomorph
	name = "Xenomorph Claw"
	id = "xenomorph"
	attack_verbs = list("claw","scratch","maul")
	weapon_name = "claws"


	//The base attack damage of the weapon. It's a flat value, unaffected by any skills or attributes.
	attack_damage_base = list(
		BLADE = DAMAGE_C,
		BLUNT = DAMAGE_E,
		PIERCE = DAMAGE_C,
		FATIGUE = DAMAGE_D
	)

	//How much armor to penetrate. It basically removes the percentage of the armor using these values.
	attack_damage_penetration = list(
		BLADE = ARMOR_C,
		BLUNT = ARMOR_C,
		PIERCE = ARMOR_C,
		FATIGUE = ARMOR_C
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

	skill_xp_per_damage = list(
		SKILL_UNARMED = SKILL_D
	)

/damagetype/npc/xenomorph/queen
	name = "Xenomorph Poisoned Claws"
	id = "xenomorph_queen"
	attack_verbs = list("claw","scratch","maul")
	weapon_name = "poisonous claws"

	//The base attack damage of the weapon. It's a flat value, unaffected by any skills or attributes.
	attack_damage_base = list(
		BLADE = DAMAGE_B,
		BLUNT = DAMAGE_D,
		PIERCE = DAMAGE_C,
		BIO = DAMAGE_C
	)

	//How much armor to penetrate. It basically removes the percentage of the armor using these values.
	attack_damage_penetration = list(
		BLADE = ARMOR_B,
		BLUNT = ARMOR_B,
		PIERCE = ARMOR_B,
		BIO = ARMOR_F
	)

	attribute_stats = list(
		ATTRIBUTE_STRENGTH = CLASS_B,
		ATTRIBUTE_DEXTERITY = CLASS_D
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

	skill_xp_per_damage = list(
		SKILL_UNARMED = SKILL_D
	)