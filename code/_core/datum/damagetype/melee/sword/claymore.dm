/damagetype/melee/sword/claymore
	name = "claymore"
	id = "sword_claymore"


	//The base attack damage of the weapon. It's a flat value, unaffected by any skills or attributes.
	attack_damage_base = list(
		BLADE = DAMAGE_C,
		PIERCE = DAMAGE_D,
	)

	//The damage conversion table of the weapon. Useful for when you want blade attacks to deal holy damage or something.
	attack_damage_conversion = list(
		BLADE = BRUTE,
		PIERCE = BRUTE,
	)

	//How much armor to penetrate. It basically removes the percentage of the armor using these values.
	attack_damage_penetration = list(
		BLADE = ARMOR_C,
		PIERCE = ARMOR_C,
	)

	attribute_stats = list(
		ATTRIBUTE_STRENGTH = CLASS_B,
		ATTRIBUTE_DEXTERITY = CLASS_D,
	)

	attribute_damage = list(
		ATTRIBUTE_STRENGTH = BLADE,
		ATTRIBUTE_DEXTERITY = PIERCE
	)

	skill_stats = list(
		SKILL_MELEE = CLASS_B
	)

	skill_damage = list(
		SKILL_MELEE = BLADE
	)

	skill_xp_per_damage = list(
		SKILL_MELEE = SKILL_B
	)