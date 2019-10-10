/damagetype/melee/club/stunbaton
	name = "stunbaton off"
	id = "stunbaton_off"

	//The base attack damage of the weapon. It's a flat value, unaffected by any skills or attributes.
	attack_damage_base = list(
		BLUNT = DAMAGE_C
	)

	//The damage conversion table of the weapon. Useful for when you want blade attacks to deal holy damage or something.
	attack_damage_conversion = list(
		BLUNT = BRUTE
	)

	//How much armor to penetrate. It basically removes the percentage of the armor using these values.
	attack_damage_penetration = list(
		BLUNT = ARMOR_D
	)

	attribute_stats = list(
		ATTRIBUTE_STRENGTH = CLASS_B,
		ATTRIBUTE_DEXTERITY = CLASS_D
	)

	attribute_damage = list(
		ATTRIBUTE_STRENGTH = BLUNT,
		ATTRIBUTE_DEXTERITY = BLUNT
	)

	skill_stats = list(
		SKILL_MELEE = CLASS_C
	)

	skill_damage = list(
		SKILL_MELEE = BLUNT
	)

	skill_xp_per_damage = list(
		SKILL_MELEE = SKILL_C
	)

/damagetype/melee/club/stunbaton/on
	name = "stunbaton on"
	id = "stunbaton_on"

	//The base attack damage of the weapon. It's a flat value, unaffected by any skills or attributes.
	attack_damage_base = list(
		FATIGUE = DAMAGE_A
	)

	//The damage conversion table of the weapon. Useful for when you want blade attacks to deal holy damage or something.
	attack_damage_conversion = list(
		FATIGUE = OXY
	)

	//How much armor to penetrate. It basically removes the percentage of the armor using these values.
	attack_damage_penetration = list(
		FATIGUE = ARMOR_A
	)

	attribute_stats = list()

	attribute_damage = list()

	skill_stats = list()

	skill_damage = list()

	skill_xp_per_damage = list()