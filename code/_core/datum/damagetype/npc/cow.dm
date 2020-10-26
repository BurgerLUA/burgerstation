/damagetype/npc/cow
	name = "cow's head"
	attack_verbs = list("headbutt")

	//The base attack damage of the weapon. It's a flat value, unaffected by any skills or attributes.
	attack_damage_base = list(
		BLUNT = DAMAGE_SWORD*0.5,
	)

	attack_damage_penetration = list(
		BLUNT = AP_SWORD,
	)

	attribute_stats = list(
		ATTRIBUTE_STRENGTH = DAMAGE_SWORD*0.5
	)

	attribute_damage = list(
		ATTRIBUTE_STRENGTH = BLUNT
	)

	attack_delay = SPEED_SWORD*0.5
	attack_delay_max = SPEED_SWORD