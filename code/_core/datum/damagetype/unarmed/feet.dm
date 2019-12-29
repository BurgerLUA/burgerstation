//Feet
/damagetype/unarmed/feet/
	name = "foot"
	id = "foot"
	attack_verbs = list("kick")


	//The base attack damage of the weapon. It's a flat value, unaffected by any skills or attributes.
	attack_damage_base = list(
		BLUNT = DAMAGE_E,
		FATIGUE = DAMAGE_C
	)

	//How much armor to penetrate. It basically removes the percentage of the armor using these values.
	attack_damage_penetration = list(
		BLUNT = ARMOR_C,
		FATIGUE = ARMOR_D
	)

	attribute_stats = list(
		ATTRIBUTE_STRENGTH = CLASS_C,
		ATTRIBUTE_DEXTERITY = CLASS_B
	)

	attribute_damage = list(
		ATTRIBUTE_STRENGTH = BLUNT,
		ATTRIBUTE_DEXTERITY = BLUNT
	)

	skill_stats = list(
		SKILL_UNARMED = CLASS_A
	)

	skill_damage = list(
		SKILL_UNARMED = BLUNT,
	)

	skill_xp_per_damage = list(
		SKILL_UNARMED = SKILL_A
	)

	throw_mul = 1