/damagetype/melee/club/shield
	name = "shield"
	id = "shield_wood"

	//The base attack damage of the weapon. It's a flat value, unaffected by any skills or attributes.
	attack_damage_base = list(
		BLUNT = DAMAGE_C,
		FATIGUE = DAMAGE_B
	)

	//How much armor to penetrate. It basically removes the percentage of the armor using these values.
	attack_damage_penetration = list(
		BLUNT = ARMOR_F,
		FATIGUE = ARMOR_S
	)

	attribute_stats = list(
		ATTRIBUTE_STRENGTH = CLASS_C,
		ATTRIBUTE_DEXTERITY = CLASS_E,
	)

	attribute_damage = list(
		ATTRIBUTE_STRENGTH = FATIGUE,
		ATTRIBUTE_DEXTERITY = BLUNT
	)

	skill_stats = list(
		SKILL_MELEE = CLASS_E,
		SKILL_BLOCK = CLASS_C
	)

	skill_damage = list(
		SKILL_MELEE = BLUNT,
		SKILL_BLOCK = BLUNT
	)

	skill_xp_per_damage = list(
		SKILL_MELEE = SKILL_D,
		SKILL_BLOCK = SKILL_D
	)

/damagetype/melee/club/shield/energy
	name = "energy shield"
	id = "shield_energy"

	//impact_sounds = list('sounds/weapon/melee/saberon.ogg')

	//The base attack damage of the weapon. It's a flat value, unaffected by any skills or attributes.
	attack_damage_base = list(
		BLUNT = DAMAGE_D,
		LASER = DAMAGE_C,
		FATIGUE = DAMAGE_B
	)

	//How much armor to penetrate. It basically removes the percentage of the armor using these values.
	attack_damage_penetration = list(
		BLUNT = ARMOR_F,
		LASER = ARMOR_F,
		FATIGUE = ARMOR_F
	)

	attribute_stats = list(
		ATTRIBUTE_STRENGTH = CLASS_D,
		ATTRIBUTE_AGILITY = CLASS_E
	)

	attribute_damage = list(
		ATTRIBUTE_STRENGTH = BLUNT,
		ATTRIBUTE_AGILITY = LASER
	)

	skill_stats = list(
		SKILL_MELEE = CLASS_D,
		SKILL_BLOCK = CLASS_C,
	)

	skill_damage = list(
		SKILL_MELEE = LASER,
		SKILL_BLOCK = FATIGUE,
	)

	skill_xp_per_damage = list(
		SKILL_MELEE = SKILL_D,
		SKILL_BLOCK = SKILL_D
	)