/damagetype/unarmed/claw
	attack_verbs = list("claw")

	hit_effect = /obj/effect/temp/impact/combat/claw

	impact_sounds = list(
		'sound/weapons/unarmed/claw_flesh_01.ogg',
		'sound/weapons/unarmed/claw_flesh_02.ogg',
		'sound/weapons/unarmed/claw_flesh_03.ogg'
	)

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
		ATTRIBUTE_STRENGTH = 25,
		ATTRIBUTE_DEXTERITY = 25
	)

	attribute_damage = list(
		ATTRIBUTE_STRENGTH = list(BLADE,PIERCE),
		ATTRIBUTE_DEXTERITY = list(BLADE,PIERCE)
	)

	skill_stats = list(
		SKILL_UNARMED = 35
	)

	skill_damage = list(
		SKILL_UNARMED = list(BLADE,PIERCE)
	)

	cqc_tag = "4"

	attack_delay = 4
	attack_delay_max = 8