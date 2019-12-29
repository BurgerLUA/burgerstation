/damagetype/npc/holy_warrior
	name = "holy warrior"
	id = "holy_warrior"
	attack_verbs = list("smite","punish","strike")


	//The base attack damage of the weapon. It's a flat value, unaffected by any skills or attributes.
	attack_damage_base = list(
		HEAT = DAMAGE_C,
		HOLY = DAMAGE_C
	)

	//How much armor to penetrate. It basically removes the percentage of the armor using these values.
	attack_damage_penetration = list(
		HEAT = ARMOR_D,
		HOLY = ARMOR_E
	)

	attribute_stats = list(
		ATTRIBUTE_STRENGTH = CLASS_C,
		ATTRIBUTE_DEXTERITY = CLASS_C
	)

	attribute_damage = list(
		ATTRIBUTE_STRENGTH = HEAT,
		ATTRIBUTE_DEXTERITY = HEAT
	)

	skill_stats = list(
		SKILL_UNARMED = CLASS_D,
		SKILL_PRAYER = CLASS_B
	)

	skill_damage = list(
		SKILL_UNARMED = HEAT,
		SKILL_PRAYER = HOLY
	)

	skill_xp_per_damage = list(
		SKILL_UNARMED = SKILL_D,
		SKILL_PRAYER = SKILL_B
	)