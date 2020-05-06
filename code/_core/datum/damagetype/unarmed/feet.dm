//Feet
/damagetype/unarmed/feet/
	name = "foot"
	attack_verbs = list("kick")


	//The base attack damage of the weapon. It's a flat value, unaffected by any skills or attributes.
	attack_damage_base = list(
		BLUNT = 5,
		FATIGUE = 0
	)

	//How much armor to penetrate. It basically removes the percentage of the armor using these values.
	attack_damage_penetration = list(
		BLUNT = 25,
		FATIGUE = 15
	)

	attribute_stats = list(
		ATTRIBUTE_STRENGTH = 50,
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

	throw_mul = 1