/damagetype/default/
	name = "default"
	id = "default"

	//The base attack damage of the weapon. It's a flat value, unaffected by any skills or attributes.
	attack_damage_base = list(
		BLUNT = 5,
	)

	//The damage conversion table of the weapon. Useful for when you want blade attacks to deal holy damage or something.
	attack_damage_conversion = list(
		BLUNT = BRUTE
	)

	//How much armor to penetrate. It basically removes the percentage of the armor using these values.
	attack_damage_penetration = list(
		BLUNT = 0
	)

	attribute_stats = list(
		ATTRIBUTE_STRENGTH = CLASS_E
	)

	attribute_damage = list(
		ATTRIBUTE_STRENGTH = BLUNT,
	)

	skill_stats = list(
		SKILL_MELEE = CLASS_E,
	)

	skill_damage = list(
		SKILL_MELEE = BLUNT
	)

	skill_xp_per_damage = list(
		SKILL_MELEE = 0.25
	)