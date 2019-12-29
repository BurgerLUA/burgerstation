/damagetype/npc/slime
	name = "slime touch"
	id = "slime_pounce"
	attack_verbs = list("blob","pounce","absorb","slime")


	//The base attack damage of the weapon. It's a flat value, unaffected by any skills or attributes.
	attack_damage_base = list(
		BIO = DAMAGE_D,
		FIRE = DAMAGE_E,
		FATIGUE = DAMAGE_D
	)

	//How much armor to penetrate. It basically removes the percentage of the armor using these values.
	attack_damage_penetration = list(
		BIO = ARMOR_A,
		FIRE = ARMOR_D,
		FATIGUE = ARMOR_E
	)

	attribute_stats = list(
		ATTRIBUTE_VITALITY = CLASS_B,
	)

	attribute_damage = list(
		ATTRIBUTE_VITALITY = BIO
	)

	skill_stats = list(
		SKILL_UNARMED = CLASS_D
	)

	skill_damage = list(
		SKILL_UNARMED = FATIGUE
	)

	skill_xp_per_damage = list(
		SKILL_UNARMED = SKILL_D
	)