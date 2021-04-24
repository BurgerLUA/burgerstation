/damagetype/npc/clown
	name = "clown honk"
	attack_verbs = list("honk")

	impact_sounds = list('sound/items/bikehorn.ogg')

	//The base attack damage of the weapon. It's a flat value, unaffected by any skills or attributes.
	attack_damage_base = list(
		BLUNT = 45*0.5,
	)

	attack_damage_penetration = list(
		BLUNT = 40*0.5,
	)

	attribute_stats = list(
		ATTRIBUTE_STRENGTH = 45*0.25
	)

	attribute_damage = list(
		ATTRIBUTE_STRENGTH = BLUNT
	)

	skill_stats = list(
		SKILL_UNARMED = 45*0.25
	)

	skill_damage = list(
		SKILL_UNARMED = BLUNT
	)

	attack_delay = 12*0.5
	attack_delay_max = 12