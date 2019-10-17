/damagetype/ranged/magic/meteor/
	name = "magic meteor"
	id = "meteor"

	//The base attack damage of the weapon. It's a flat value, unaffected by any skills or attributes.
	attack_damage_base = list(
		BLUNT = DAMAGE_C,
		PIERCE = DAMAGE_E,
		MAGIC = DAMAGE_C,
		BOMB = DAMAGE_A
	)

	//The damage conversion table of the weapon. Useful for when you want blade attacks to deal holy damage or something.
	attack_damage_penetration = list(
		BLUNT = ARMOR_C,
		PIERCE = ARMOR_C,
		MAGIC = ARMOR_D,
		BOMB = ARMOR_E
	)

	attack_damage_penetration = list(
		BLUNT = BRUTE,
		PIERCE = BRUTE,
		MAGIC = BRUTE,
		BOMB = BRUTE
	)

	attribute_stats = list(
		ATTRIBUTE_INTELLIGENCE = CLASS_D
	)

	attribute_damage = list(
		ATTRIBUTE_INTELLIGENCE = BOMB
	)

	skill_stats = list(
		SKILL_MAGIC = CLASS_D,
	)

	skill_damage = list(
		SKILL_MAGIC = BOMB
	)

	skill_xp_per_damage = list(
		SKILL_MAGIC = SKILL_D
	)