/damagetype/npc/cow
	name = "cow's head"
	attack_verbs = list("headbutt")

	//The base attack damage of the weapon. It's a flat value, unaffected by any skills or attributes.
	attack_damage_base = list(
		BLUNT = 30*0.5,
	)

	attack_damage_penetration = list(
		BLUNT = 20,
	)

	attribute_stats = list(
		ATTRIBUTE_STRENGTH = 30*0.5
	)

	attribute_damage = list(
		ATTRIBUTE_STRENGTH = BLUNT
	)

	attack_delay = 10*0.5
	attack_delay_max = 10