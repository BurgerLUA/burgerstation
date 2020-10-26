/damagetype/npc/crab
	name = "crab claw"
	attack_verbs = list("pinch","snip")

	//The base attack damage of the weapon. It's a flat value, unaffected by any skills or attributes.
	attack_damage_base = list(
		BLADE = DAMAGE_SWORD*0.3,
		PIERCE = DAMAGE_SWORD*0.1,
	)

	attack_damage_penetration = list(
		BLADE = AP_SWORD*0.25,
		PIERCE = AP_SWORD*0.75
	)

	attribute_stats = list(
		ATTRIBUTE_STRENGTH = DAMAGE_SWORD*0.4,
		ATTRIBUTE_DEXTERITY = DAMAGE_SWORD*0.2
	)

	attribute_damage = list(
		ATTRIBUTE_STRENGTH = list(BLADE,PIERCE),
		ATTRIBUTE_DEXTERITY = list(BLADE,PIERCE)
	)

	attack_delay = SPEED_SWORD*0.5
	attack_delay_max = SPEED_SWORD