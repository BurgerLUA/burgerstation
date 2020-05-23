/damagetype/unarmed/beef/
	name = "beef"
	attack_verbs = list("maul")

	//The base attack damage of the weapon. It's a flat value, unaffected by any skills or attributes.
	attack_damage_base = list(
		BLUNT = 10,
		HEAT = 5,
		COLD = 5,
		BIO = 10,
		DARK = 30,
		FATIGUE = 20
	)

	impact_sounds = list(
		'sounds/weapons/beef/beef_hit.ogg'
	)

	//How much armor to penetrate. It basically removes the percentage of the armor using these values.
	attack_damage_penetration = list(
		BLUNT = 25,
		HEAT = 25,
		COLD = 25,
		BIO = 25,
		DARK = 25,
		FATIGUE = 25
	)

	attribute_stats = list(
		ATTRIBUTE_STRENGTH = 50,
		ATTRIBUTE_DEXTERITY = 25
	)

	attribute_damage = list(
		ATTRIBUTE_STRENGTH = list(BLUNT,FATIGUE),
		ATTRIBUTE_DEXTERITY = list(BLUNT,FATIGUE)
	)

	skill_stats = list(
		SKILL_UNARMED = 50
	)

	skill_damage = list(
		SKILL_UNARMED = list(BLUNT,FATIGUE),
	)

	throw_mul = 1