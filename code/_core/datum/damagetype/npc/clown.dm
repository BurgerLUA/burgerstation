/damagetype/npc/clown
	name = "clown honk"
	attack_verbs = list("honk")

	impact_sounds = list('sound/items/bikehorn.ogg')

	//The base attack damage of the weapon. It's a flat value, unaffected by any skills or attributes.
	attack_damage_base = list(
		BLUNT = DAMAGE_AXE*0.5,
	)

	attack_damage_penetration = list(
		BLUNT = AP_AXE*0.5,
	)

	attribute_stats = list(
		ATTRIBUTE_STRENGTH = DAMAGE_AXE*0.25
	)

	attribute_damage = list(
		ATTRIBUTE_STRENGTH = BLUNT
	)

	skill_stats = list(
		SKILL_UNARMED = DAMAGE_AXE*0.25
	)

	skill_damage = list(
		SKILL_UNARMED = BLUNT
	)

	attack_delay = SPEED_AXE*0.5
	attack_delay_max = SPEED_AXE