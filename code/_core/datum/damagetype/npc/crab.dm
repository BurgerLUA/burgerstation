/damagetype/npc/crab
	name = "crab claw"
	attack_verbs = list("pinch","snip")

	//The base attack damage of the weapon. It's a flat value, unaffected by any skills or attributes.
	attack_damage_base = list(
		BLADE = 5,
		PIERCE = 10,
	)

	attack_damage_penetration = list(
		BLADE = 5,
		PIERCE = 10
	)

	attribute_stats = list(
		ATTRIBUTE_STRENGTH = 40,
		ATTRIBUTE_DEXTERITY = 10
	)

	attribute_damage = list(
		ATTRIBUTE_STRENGTH = list(BLADE,PIERCE),
		ATTRIBUTE_DEXTERITY = list(BLADE,PIERCE)
	)

/damagetype/npc/crab/king
	name = "giant crab claw"
	attack_verbs = list("pinch","snip")

	//The base attack damage of the weapon. It's a flat value, unaffected by any skills or attributes.
	attack_damage_base = list(
		BLADE = 30,
		PIERCE = 15,
	)

	attack_damage_penetration = list(
		BLADE = 50,
		PIERCE = 50
	)

	attribute_stats = list(
		ATTRIBUTE_STRENGTH = 70,
		ATTRIBUTE_DEXTERITY = 10
	)

	attribute_damage = list(
		ATTRIBUTE_STRENGTH = list(BLADE,PIERCE),
		ATTRIBUTE_DEXTERITY = list(BLADE,PIERCE)
	)