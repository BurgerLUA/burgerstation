/damagetype/npc/bubblegum
	name = "bubblegum smash"
	attack_verbs = list("hit","smack")

	//The base attack damage of the weapon. It's a flat value, unaffected by any skills or attributes.
	attack_damage_base = list(
		BLUNT = 0
	)

	attack_damage_penetration = list(
		BLUNT = 50
	)

	attribute_stats = list(
		ATTRIBUTE_STRENGTH = 200
	)

	attribute_damage = list(
		ATTRIBUTE_STRENGTH = BLUNT
	)