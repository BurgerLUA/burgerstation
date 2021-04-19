/damagetype/melee/club/gun_butt
	name = "gun butt"

	//The base attack damage of the weapon. It's a flat value, unaffected by any skills or attributes.
	attack_damage_base = list(
		BLUNT = 30*0.1
	)

	//How much armor to penetrate. It basically removes the percentage of the armor using these values.
	attack_damage_penetration = list(
		BLUNT = 20
	)

	attribute_stats = list(
		ATTRIBUTE_STRENGTH = 30*0.45
	)

	attribute_damage = list(
		ATTRIBUTE_STRENGTH = BLUNT
	)

	skill_stats = list(
		SKILL_MELEE = 30*0.45
	)

	skill_damage = list(
		SKILL_MELEE = BLUNT
	)

	attack_delay = 10*0.5
	attack_delay_max = 10