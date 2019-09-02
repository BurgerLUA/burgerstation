/damagetype/npc/slime
	name = "Slime Pounce"
	id = "slime_pounce"
	desc = "The pounce of a slime"
	attack_verbs = list("blob","pounce","absorb","slime")
	weapon_name = "slime"


	//The base attack damage of the weapon. It's a flat value, unaffected by any skills or attributes.
	attack_damage_base = list(
		BIO = 10,
		FIRE = 10,
		FATIGUE = 10
	)

	//The damage conversion table of the weapon. Useful for when you want blade attacks to deal holy damage or something.
	attack_damage_conversion = list(
		BIO = TOX,
		FIRE = BURN,
		FATIGUE = OXY
	)

	//How much armor to penetrate. It basically removes the percentage of the armor using these values.
	attack_damage_penetration = list(
		BIO = 50,
		FIRE = 50,
		FATIGUE = 0
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

	skill_xp_per_damage = list()