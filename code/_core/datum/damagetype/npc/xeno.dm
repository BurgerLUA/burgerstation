/damagetype/npc/xeno
	name = "xeno claw"
	attack_verbs = list("claw","scratch","maul")

	hit_effect = /obj/effect/temp/impact/combat/claw

	//The base attack damage of the weapon. It's a flat value, unaffected by any skills or attributes.
	attack_damage_base = list(
		BLADE = DAMAGE_SWORD*0.25,
		PIERCE = DAMAGE_SWORD*0.25,
	)

	//How much armor to penetrate. It basically removes the percentage of the armor using these values.
	attack_damage_penetration = list(
		BLADE = AP_SWORD*0.5,
		BLUNT = AP_SWORD*0.5,
	)

	attribute_stats = list(
		ATTRIBUTE_STRENGTH = DAMAGE_SWORD*0.25,
		ATTRIBUTE_DEXTERITY = DAMAGE_SWORD*0.25
	)

	attribute_damage = list(
		ATTRIBUTE_STRENGTH = BLADE,
		ATTRIBUTE_DEXTERITY = PIERCE
	)

/damagetype/npc/xeno/queen
	name = "queen xeno poison claw"

	//The base attack damage of the weapon. It's a flat value, unaffected by any skills or attributes.
	attack_damage_base = list(
		BLADE = DAMAGE_SWORD*0.2,
		PIERCE = DAMAGE_SWORD*0.2,
		BIO = DAMAGE_SWORD*0.1
	)

	//How much armor to penetrate. It basically removes the percentage of the armor using these values.
	attack_damage_penetration = list(
		BLADE = AP_SWORD*0.4,
		BLUNT = AP_SWORD*0.4,
		BIO = AP_SWORD*0.2
	)

	attribute_stats = list(
		ATTRIBUTE_STRENGTH = DAMAGE_SWORD*0.2,
		ATTRIBUTE_DEXTERITY = DAMAGE_SWORD*0.2,
		ATTRIBUTE_VITALITY = DAMAGE_SWORD*0.1
	)

	attribute_damage = list(
		ATTRIBUTE_STRENGTH = BLADE,
		ATTRIBUTE_DEXTERITY = PIERCE,
		ATTRIBUTE_VITALITY = BIO
	)