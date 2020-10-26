/damagetype/npc/bull
	name = "Bull Gore"

	//The base attack damage of the weapon. It's a flat value, unaffected by any skills or attributes.
	attack_damage_base = list(
		BLUNT = DAMAGE_CLUB*0.2,
		PIERCE = DAMAGE_CLUB*0.3,
	)

	//How much armor to penetrate. It basically removes the percentage of the armor using these values.
	attack_damage_penetration = list(
		BLUNT = AP_CLUB*0.25,
		PIERCE = AP_CLUB*0.75,
	)


	attribute_stats = list(
		ATTRIBUTE_STRENGTH = DAMAGE_CLUB*0.5
	)

	attribute_damage = list(
		ATTRIBUTE_STRENGTH = PIERCE
	)

	attack_delay = SPEED_CLUB*0.5
	attack_delay_max = SPEED_CLUB