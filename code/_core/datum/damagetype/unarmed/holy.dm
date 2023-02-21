/damagetype/unarmed/holy
	attack_verbs = list("bless","exorcise","smite","beatify","sanctify","proselytizes")

	hit_effect = /obj/effect/temp/impact/combat/punch

	//The base attack damage of the weapon. It's a flat value, unaffected by any skills or attributes.
	attack_damage_base = list(
		BLUNT = 10,
		HOLY = 0
	)

	//How much armor to penetrate. It basically removes the percentage of the armor using these values.
	attack_damage_penetration = list(
		BLUNT = 0,
		HOLY = 0
	)

	attribute_stats = list(
		ATTRIBUTE_STRENGTH = 25,
		ATTRIBUTE_DEXTERITY = 10
	)

	attribute_damage = list(
		ATTRIBUTE_STRENGTH = BLUNT,
		ATTRIBUTE_DEXTERITY = BLUNT
	)

	skill_stats = list(
		SKILL_UNARMED = 30,
		SKILL_PRAYER = 60
	)

	skill_damage = list(
		SKILL_UNARMED = BLUNT,
		SKILL_PRAYER = HOLY
	)

	cqc_tag = "4"

	attack_delay = 5
	attack_delay_max = 10

/damagetype/unarmed/holy/slam
	damage_mod = 2


/damagetype/unarmed/holy/spiked
	attack_verbs = list("curse","defile","desecrate","taint","blaspheme","pollute")

	//The base attack damage of the weapon. It's a flat value, unaffected by any skills or attributes.
	attack_damage_base = list(
		BLUNT = 10,
		PIERCE = 15,
		DARK = 0
	)

	//How much armor to penetrate. It basically removes the percentage of the armor using these values.
	attack_damage_penetration = list(
		BLUNT = 25,
		PIERCE = 25,
		DARK = 25
	)

	attribute_stats = list(
		ATTRIBUTE_STRENGTH = 25,
		ATTRIBUTE_DEXTERITY = 10
	)

	attribute_damage = list(
		ATTRIBUTE_STRENGTH = list(BLUNT,PIERCE),
		ATTRIBUTE_DEXTERITY = list(BLUNT,PIERCE)
	)

	skill_stats = list(
		SKILL_UNARMED = 30,
		SKILL_PRAYER = 60

	)

	skill_damage = list(
		SKILL_UNARMED = list(BLUNT,PIERCE),
		SKILL_PRAYER = DARK
	)

	cqc_tag = "4"

	attack_delay = 7
	attack_delay_max = 15