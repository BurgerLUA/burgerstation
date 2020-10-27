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

	attack_delay = SPEED_SWORD*0.5
	attack_delay_max = SPEED_SWORD

/damagetype/npc/xeno/queen
	name = "queen xeno poison claw"

	//The base attack damage of the weapon. It's a flat value, unaffected by any skills or attributes.
	attack_damage_base = list(
		BLADE = DAMAGE_AXE*0.2,
		PIERCE = DAMAGE_AXE*0.2,
		BIO = DAMAGE_AXE*0.1
	)

	//How much armor to penetrate. It basically removes the percentage of the armor using these values.
	attack_damage_penetration = list(
		BLADE = DAMAGE_AXE*0.4,
		BLUNT = DAMAGE_AXE*0.4,
		BIO = DAMAGE_AXE*0.2
	)

	attribute_stats = list(
		ATTRIBUTE_STRENGTH = DAMAGE_AXE*0.2,
		ATTRIBUTE_DEXTERITY = DAMAGE_AXE*0.2,
		ATTRIBUTE_VITALITY = DAMAGE_AXE*0.1
	)

	attribute_damage = list(
		ATTRIBUTE_STRENGTH = BLADE,
		ATTRIBUTE_DEXTERITY = PIERCE,
		ATTRIBUTE_VITALITY = BIO
	)

	attack_delay = SPEED_AXE*0.5
	attack_delay_max = SPEED_AXE