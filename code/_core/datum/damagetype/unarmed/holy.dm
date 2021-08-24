/damagetype/unarmed/holy
	name = "blessed knuckle"
	attack_verbs = list("bless","exorcise","smite","beatify","sanctify","proselytizes")

	hit_effect = /obj/effect/temp/impact/combat/punch

	//The base attack damage of the weapon. It's a flat value, unaffected by any skills or attributes.
	attack_damage_base = list(
		BLUNT = 55*0.4,
		HOLY = 50*0.1
	)

	//How much armor to penetrate. It basically removes the percentage of the armor using these values.
	attack_damage_penetration = list(
		BLUNT = 0,
		HOLY = 0
	)

	attribute_stats = list(
		ATTRIBUTE_STRENGTH = 55*0.2,
		ATTRIBUTE_DEXTERITY = 55*0.1
	)

	attribute_damage = list(
		ATTRIBUTE_STRENGTH = list(BLUNT),
		ATTRIBUTE_DEXTERITY = list(BLUNT)
	)

	skill_stats = list(
		SKILL_UNARMED = 55*0.3,
		SKILL_PRAYER = 55*0.1
	)

	skill_damage = list(
		SKILL_UNARMED = list(BLUNT),
		SKILL_PRAYER = list(HOLY)
	)

	bonus_experience_skill = list(
		SKILL_UNARMED = 25, //25%
		SKILL_PRAYER = 25
	)


	attack_delay = 11*0.5
	attack_delay_max = 11