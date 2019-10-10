/damagetype/npc/goliath/
	name = "goliath claw"
	id = "goliath_claw"

	//The base attack damage of the weapon. It's a flat value, unaffected by any skills or attributes.
	attack_damage_base = list(
		BLADE = DAMAGE_D,
		PIERCE = DAMAGE_C
	)

	//The damage conversion table of the weapon. Useful for when you want blade attacks to deal holy damage or something.
	attack_damage_conversion = list(
		BLADE = BRUTE,
		PIERCE = BRUTE
	)

	//How much armor to penetrate. It basically removes the percentage of the armor using these values.
	attack_damage_penetration = list(
		BLADE = ARMOR_D,
		PIERCE = ARMOR_C
	)

	attribute_stats = list(
		ATTRIBUTE_STRENGTH = CLASS_C,
		ATTRIBUTE_DEXTERITY = CLASS_D
	)

	attribute_damage = list(
		ATTRIBUTE_STRENGTH = PIERCE,
		ATTRIBUTE_DEXTERITY = BLADE,
	)

	skill_stats = list(
		SKILL_UNARMED = CLASS_D
	)

	skill_damage = list(
		SKILL_UNARMED = PIERCE
	)

	skill_xp_per_damage = list(
		SKILL_UNARMED = SKILL_D
	)

/damagetype/npc/goliath/tentacle
	name = "goliath tentacle"
	id = "goliath_tentacle"

	//The base attack damage of the weapon. It's a flat value, unaffected by any skills or attributes.
	attack_damage_base = list(
		BLADE = DAMAGE_D,
		BLUNT = DAMAGE_D,
		PIERCE = DAMAGE_B,
		DARK = DAMAGE_C
	)

	//The damage conversion table of the weapon. Useful for when you want blade attacks to deal holy damage or something.
	attack_damage_conversion = list(
		BLADE = BRUTE,
		BLUNT = BRUTE,
		PIERCE = BRUTE,
		DARK = BURN
	)

	//How much armor to penetrate. It basically removes the percentage of the armor using these values.
	attack_damage_penetration = list(
		BLADE = ARMOR_D,
		BLUNT = ARMOR_F,
		PIERCE = ARMOR_C,
		DARK = ARMOR_B
	)

	attribute_stats = list()

	attribute_damage = list()

	skill_stats = list()

	skill_damage = list()

	skill_xp_per_damage = list()