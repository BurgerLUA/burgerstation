/damagetype/unarmed/claw/
	name = "claw"
	attack_verbs = list("claw")

	hit_effect = /obj/effect/temp/impact/combat/claw


	//The base attack damage of the weapon. It's a flat value, unaffected by any skills or attributes.
	attack_damage_base = list(
		BLADE = 10,
		PIERCE = 5
	)

	//How much armor to penetrate. It basically removes the percentage of the armor using these values.
	attack_damage_penetration = list(
		BLADE = 25,
		PIERCE = 25
	)

	attribute_stats = list(
		ATTRIBUTE_STRENGTH = 50,
		ATTRIBUTE_DEXTERITY = 25
	)

	attribute_damage = list(
		ATTRIBUTE_STRENGTH = list(BLADE,PIERCE),
		ATTRIBUTE_DEXTERITY = list(BLADE,PIERCE)
	)

	skill_stats = list(
		SKILL_UNARMED = 50
	)

	skill_damage = list(
		SKILL_UNARMED = list(BLADE,PIERCE),
	)

	throw_mul = 1