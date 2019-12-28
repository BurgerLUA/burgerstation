/damagetype/npc/cultist
	name = "Cultist Damage"
	id = "cultist"
	attack_verbs = list("slash","stab")
	weapon_name = "dark blade"


	//The base attack damage of the weapon. It's a flat value, unaffected by any skills or attributes.
	attack_damage_base = list(
		BLADE = DAMAGE_D,
		PIERCE = DAMAGE_E,
		MAGIC = DAMAGE_E,
		DARK = DAMAGE_C
	)

	//How much armor to penetrate. It basically removes the percentage of the armor using these values.
	attack_damage_penetration = list(
		BLADE = ARMOR_F,
		PIERCE = ARMOR_F,
		MAGIC = ARMOR_C,
		DARK = ARMOR_C
	)

	attribute_stats = list(
		ATTRIBUTE_STRENGTH = CLASS_D,
		ATTRIBUTE_DEXTERITY = CLASS_C,
		ATTRIBUTE_INTELLIGENCE = CLASS_A
	)

	attribute_damage = list(
		ATTRIBUTE_STRENGTH = BLADE,
		ATTRIBUTE_DEXTERITY = BLADE,
		ATTRIBUTE_INTELLIGENCE = MAGIC
	)

	skill_stats = list(
		SKILL_MELEE = CLASS_D,
		SKILL_PRAYER = CLASS_A
	)

	skill_damage = list(
		SKILL_MELEE = BLADE,
		SKILL_PRAYER = DARK
	)

	skill_xp_per_damage = list(
		SKILL_MELEE = SKILL_D,
		SKILL_PRAYER = SKILL_B
	)

/damagetype/npc/harvester
	name = "Harvester Damage"
	id = "harvester"
	attack_verbs = list("slash","pummel")
	weapon_name = "dark claws"

	//The base attack damage of the weapon. It's a flat value, unaffected by any skills or attributes.
	attack_damage_base = list(
		BLADE = DAMAGE_D,
		BLUNT = DAMAGE_E,
		PIERCE = DAMAGE_D,
		MAGIC = DAMAGE_E,
		DARK = DAMAGE_C
	)

	//How much armor to penetrate. It basically removes the percentage of the armor using these values.
	attack_damage_penetration = list(
		BLADE = ARMOR_F,
		BLUNT = ARMOR_F,
		PIERCE = ARMOR_F,
		MAGIC = ARMOR_D,
		DARK = ARMOR_C
	)

	attribute_stats = list(
		ATTRIBUTE_STRENGTH = CLASS_C,
		ATTRIBUTE_DEXTERITY = CLASS_C,
		ATTRIBUTE_INTELLIGENCE = CLASS_C
	)

	attribute_damage = list(
		ATTRIBUTE_STRENGTH = BLUNT,
		ATTRIBUTE_DEXTERITY = BLADE,
		ATTRIBUTE_INTELLIGENCE = MAGIC
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

/damagetype/npc/behemoth
	name = "Behemoth Damage"
	id = "behemoth"
	attack_verbs = list("slam","slap","pummel")
	weapon_name = "dark fists"


	//The base attack damage of the weapon. It's a flat value, unaffected by any skills or attributes.
	attack_damage_base = list(
		BLUNT = DAMAGE_C,
		DARK = DAMAGE_C
	)

	//How much armor to penetrate. It basically removes the percentage of the armor using these values.
	attack_damage_penetration = list(
		BLUNT = ARMOR_D,
		DARK = ARMOR_C
	)

	attribute_stats = list(
		ATTRIBUTE_STRENGTH = CLASS_B,
		ATTRIBUTE_DEXTERITY = CLASS_D,
		ATTRIBUTE_INTELLIGENCE = CLASS_D
	)

	attribute_damage = list(
		ATTRIBUTE_STRENGTH = BLUNT,
		ATTRIBUTE_DEXTERITY = BLUNT,
		ATTRIBUTE_INTELLIGENCE = DARK
	)

	skill_stats = list(
		SKILL_UNARMED = CLASS_D
	)

	skill_damage = list(
		SKILL_UNARMED = BLUNT
	)

	skill_xp_per_damage = list(
		SKILL_UNARMED = SKILL_D
	)