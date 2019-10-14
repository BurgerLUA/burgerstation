/damagetype/melee/sword/zweihander
	name = "chaos zweihander"
	id = "sword_chaos_zweihander"


	//The base attack damage of the weapon. It's a flat value, unaffected by any skills or attributes.
	attack_damage_base = list(
		BLADE = DAMAGE_B,
		PIERCE = DAMAGE_D,
		DARK = DAMAGE_S
	)

	//How much armor to penetrate. It basically removes the percentage of the armor using these values.
	attack_damage_penetration = list(
		BLADE = ARMOR_C,
		PIERCE = ARMOR_C,
		DARK = ARMOR_D
	)

	attribute_stats = list(
		ATTRIBUTE_STRENGTH = CLASS_E,
		ATTRIBUTE_DEXTERITY = CLASS_E
	)

	attribute_damage = list(
		ATTRIBUTE_STRENGTH = BLADE,
		ATTRIBUTE_DEXTERITY = PIERCE
	)

	skill_stats = list(
		SKILL_MELEE = CLASS_D,
		SKILL_MAGIC_CHAOS = CLASS_S
	)

	skill_damage = list(
		SKILL_MELEE = BLADE,
		SKILL_MAGIC_CHAOS = DARK
	)

	skill_xp_per_damage = list(
		SKILL_MELEE = SKILL_E,
		SKILL_MAGIC_CHAOS = SKILL_A
	)