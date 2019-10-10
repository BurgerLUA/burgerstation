/damagetype/flashlight
	name = "flash light"
	id = "flashlight"

	//The base attack damage of the weapon. It's a flat value, unaffected by any skills or attributes.
	attack_damage_base = list(
		BLUNT = DAMAGE_E
	)

	//The damage conversion table of the weapon. Useful for when you want blade attacks to deal holy damage or something.
	attack_damage_conversion = list(
		BLUNT = BRUTE
	)

	//How much armor to penetrate. It basically removes the percentage of the armor using these values.
	attack_damage_penetration = list(
		BLUNT = ARMOR_F
	)

	attribute_stats = list(
		ATTRIBUTE_STRENGTH = CLASS_C,
		ATTRIBUTE_DEXTERITY = CLASS_E
	)

	attribute_damage = list(
		ATTRIBUTE_STRENGTH = BLUNT,
		ATTRIBUTE_DEXTERITY = BLUNT
	)

	skill_stats = list(
		SKILL_MELEE = CLASS_E
	)

	skill_damage = list(
		SKILL_MELEE = BLUNT
	)

	skill_xp_per_damage = list(
		SKILL_MELEE = SKILL_E
	)

/damagetype/flashlight/on

	name = "flashlight"
	id = "flashlight_on"

	//The base attack damage of the weapon. It's a flat value, unaffected by any skills or attributes.
	attack_damage_base = list(
		HOLY = DAMAGE_B
	)

	//The damage conversion table of the weapon. Useful for when you want blade attacks to deal holy damage or something.
	attack_damage_conversion = list(
		HOLY = BURN
	)

	//How much armor to penetrate. It basically removes the percentage of the armor using these values.
	attack_damage_penetration = list(
		HOLY = ARMOR_F
	)

	attribute_stats = list()

	attribute_damage = list()

	skill_stats = list()

	skill_damage = list()

	skill_xp_per_damage = list()