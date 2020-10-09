/damagetype/npc/clown
	name = "clown honk"
	attack_verbs = list("honk")

	impact_sounds = list('sound/items/bikehorn.ogg')

	//The base attack damage of the weapon. It's a flat value, unaffected by any skills or attributes.
	attack_damage_base = list(
		BLUNT = 20,
	)

	attack_damage_penetration = list(
		BLUNT = 25,
	)

	attribute_stats = list(
		ATTRIBUTE_STRENGTH = 50
	)

	attribute_damage = list(
		ATTRIBUTE_STRENGTH = BLUNT
	)

	skill_stats = list(
		SKILL_UNARMED = 30
	)

	skill_damage = list(
		SKILL_UNARMED = BLUNT
	)