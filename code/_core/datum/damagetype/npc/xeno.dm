/damagetype/npc/xeno
	name = "xeno claw"
	attack_verbs = list("claw","scratch","maul")

	hit_effect = /obj/effect/temp/impact/combat/claw

	//The base attack damage of the weapon. It's a flat value, unaffected by any skills or attributes.
	attack_damage_base = list(
		BLADE = 30*0.25,
		PIERCE = 30*0.25,
	)

	//How much armor to penetrate. It basically removes the percentage of the armor using these values.
	attack_damage_penetration = list(
		BLADE = 20*0.5,
		BLUNT = 20*0.5,
	)

	attribute_stats = list(
		ATTRIBUTE_STRENGTH = 30*0.25,
		ATTRIBUTE_DEXTERITY = 30*0.25
	)

	attribute_damage = list(
		ATTRIBUTE_STRENGTH = BLADE,
		ATTRIBUTE_DEXTERITY = PIERCE
	)

	attack_delay = 10*0.5
	attack_delay_max = 10

/damagetype/npc/xeno/queen
	name = "queen xeno poison claw"

	//The base attack damage of the weapon. It's a flat value, unaffected by any skills or attributes.
	attack_damage_base = list(
		BLADE = 45*0.2,
		PIERCE = 45*0.2,
		BIO = 45*0.1
	)

	//How much armor to penetrate. It basically removes the percentage of the armor using these values.
	attack_damage_penetration = list(
		BLADE = 45*0.4,
		BLUNT = 45*0.4,
		BIO = 45*0.2
	)

	attribute_stats = list(
		ATTRIBUTE_STRENGTH = 45*0.2,
		ATTRIBUTE_DEXTERITY = 45*0.2,
		ATTRIBUTE_VITALITY = 45*0.1
	)

	attribute_damage = list(
		ATTRIBUTE_STRENGTH = BLADE,
		ATTRIBUTE_DEXTERITY = PIERCE,
		ATTRIBUTE_VITALITY = BIO
	)

	attack_delay = 12*0.5
	attack_delay_max = 12