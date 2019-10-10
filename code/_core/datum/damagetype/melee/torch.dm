/damagetype/torch/
	name = "torch"
	id = "torch"

	//The base attack damage of the weapon. It's a flat value, unaffected by any skills or attributes.
	attack_damage_base = list(
		BLUNT = DAMAGE_D,
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
		SKILL_MELEE = CLASS_D
	)

	skill_damage = list(
		SKILL_MELEE = BLUNT,
	)

	skill_xp_per_damage = list(
		SKILL_MELEE = SKILL_D
	)

/damagetype/torch/on
	name = "torch"
	id = "torch_on"

	//The base attack damage of the weapon. It's a flat value, unaffected by any skills or attributes.
	attack_damage_base = list(
		BLUNT = DAMAGE_D,
		HEAT = DAMAGE_C
	)

	//The damage conversion table of the weapon. Useful for when you want blade attacks to deal holy damage or something.
	attack_damage_conversion = list(
		BLUNT = BRUTE,
		HEAT = BURN
	)

	//How much armor to penetrate. It basically removes the percentage of the armor using these values.
	attack_damage_penetration = list(
		BLUNT = ARMOR_F,
		HEAT = ARMOR_E
	)