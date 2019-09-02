//Feet
/damagetype/unarmed/feet/
	name = "Foot"
	id = "human_foot_right"
	desc = "Your foot"
	attack_verbs = list("kick")
	weapon_name = "foot"


	//The base attack damage of the weapon. It's a flat value, unaffected by any skills or attributes.
	attack_damage_base = list(
		BLUNT = -10
	)

	//The damage conversion table of the weapon. Useful for when you want blade attacks to deal holy damage or something.
	attack_damage_conversion = list(
		BLUNT = BRUTE
	)

	//How much armor to penetrate. It basically removes the percentage of the armor using these values.
	attack_damage_penetration = list(
		BLUNT = 75
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
		SKILL_UNARMED = 1
	)