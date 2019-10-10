/damagetype/npc/bear
	name = "Bear claw"
	id = "bear_claw"
	desc = "The claw of a bear"
	attack_verbs = list("slash","maul")
	weapon_name = "claw"

	//The base attack damage of the weapon. It's a flat value, unaffected by any skills or attributes.
	attack_damage_base = list(
		BLADE = DAMAGE_C,
		BLUNT = DAMAGE_E,
		PIERCE = DAMAGE_C
	)

	//The damage conversion table of the weapon. Useful for when you want blade attacks to deal holy damage or something.
	attack_damage_conversion = list(
		BLADE = BRUTE,
		BLUNT = BRUTE,
		PIERCE = BRUTE
	)

	//How much armor to penetrate. It basically removes the percentage of the armor using these values.
	attack_damage_penetration = list(
		BLADE = ARMOR_D,
		BLUNT = ARMOR_D,
		PIERCE = ARMOR_D,
	)

	attribute_stats = list(
		ATTRIBUTE_STRENGTH = CLASS_A,
		ATTRIBUTE_DEXTERITY = CLASS_D
	)

	attribute_damage = list(
		ATTRIBUTE_STRENGTH = BLADE,
		ATTRIBUTE_DEXTERITY = PIERCE
	)

	skill_stats = list(
		SKILL_UNARMED = CLASS_C
	)

	skill_damage = list(
		SKILL_UNARMED = BLADE
	)

	skill_xp_per_damage = list(
		SKILL_UNARMED = SKILL_D
	)