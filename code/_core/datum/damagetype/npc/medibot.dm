/damagetype/npc/medibot
	name = "Medibot Ram"
	attack_verbs = list("ram","drive")

	//The base attack damage of the weapon. It's a flat value, unaffected by any skills or attributes.
	attack_damage_base = list(
		BLUNT = DAMAGE_SWORD*0.25
	)

	//How much armor to penetrate. It basically removes the percentage of the armor using these values.
	attack_damage_penetration = list(
		BLUNT = AP_SWORD
	)

	attribute_stats = list(
		ATTRIBUTE_STRENGTH = DAMAGE_SWORD*0.75
	)

	attribute_damage = list(
		ATTRIBUTE_STRENGTH = BLUNT
	)

	attack_delay = SPEED_SWORD*0.5
	attack_delay_max = SPEED_SWORD