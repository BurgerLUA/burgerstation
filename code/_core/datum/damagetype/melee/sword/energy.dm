/damagetype/sword/energy
	name = "energy sword"
	id = "sword_energy_off"

	//The base attack damage of the weapon. It's a flat value, unaffected by any skills or attributes.
	attack_damage_base = list(
		BLUNT = DAMAGE_E,
		FATIGUE = DAMAGE_D
	)

	//The damage conversion table of the weapon. Useful for when you want blade attacks to deal holy damage or something.
	attack_damage_conversion = list(
		BLUNT = BRUTE
	)

	//How much armor to penetrate. It basically removes the percentage of the armor using these values.
	attack_damage_penetration = list(
		BLUNT = ARMOR_D,
		FATIGUE = ARMOR_A
	)

	attribute_stats = list(
		ATTRIBUTE_STRENGTH = CLASS_C,
		ATTRIBUTE_DEXTERITY = CLASS_C
	)

	attribute_damage = list(
		ATTRIBUTE_STRENGTH = BLUNT,
		ATTRIBUTE_DEXTERITY = BLUNT
	)

	skill_stats = list(
		SKILL_MELEE = CLASS_D,
	)

	skill_damage = list(
		SKILL_MELEE = BLUNT
	)

	skill_xp_per_damage = list(
		SKILL_MELEE = SKILL_D
	)

/damagetype/sword/energy/on
	name = "energy sword"
	id = "sword_energy_on"

	//The base attack damage of the weapon. It's a flat value, unaffected by any skills or attributes.
	attack_damage_base = list(
		LASER = DAMAGE_A
	)

	//The damage conversion table of the weapon. Useful for when you want blade attacks to deal holy damage or something.
	attack_damage_conversion = list(
		LASER = BRUTE
	)

	//How much armor to penetrate. It basically removes the percentage of the armor using these values.
	attack_damage_penetration = list(
		LASER = ARMOR_A
	)

	attribute_stats = list(
		ATTRIBUTE_STRENGTH = CLASS_E,
		ATTRIBUTE_DEXTERITY = CLASS_D
	)

	attribute_damage = list(
		ATTRIBUTE_STRENGTH = LASER,
		ATTRIBUTE_DEXTERITY = LASER
	)

	skill_stats = list(
		SKILL_MELEE = CLASS_D,
	)

	skill_damage = list(
		SKILL_MELEE = LASER
	)

	skill_xp_per_damage = list(
		SKILL_MELEE = SKILL_D
	)