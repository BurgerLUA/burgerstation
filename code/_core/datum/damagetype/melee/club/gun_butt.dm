/damagetype/melee/club/gun_butt
	name = "gun butt"

	//The base attack damage of the weapon. It's a flat value, unaffected by any skills or attributes.
	attack_damage_base = list(
		BLUNT = DAMAGE_SWORD*0.1*BASE_MELEE_MUL
	)

	//How much armor to penetrate. It basically removes the percentage of the armor using these values.
	attack_damage_penetration = list(
		BLUNT = AP_SWORD
	)

	attribute_stats = list(
		ATTRIBUTE_STRENGTH = DAMAGE_SWORD*0.45
	)

	attribute_damage = list(
		ATTRIBUTE_STRENGTH = BLUNT
	)

	skill_stats = list(
		SKILL_MELEE = DAMAGE_SWORD*0.45
	)

	skill_damage = list(
		SKILL_MELEE = BLUNT
	)

	attack_delay = SPEED_SWORD*0.5
	attack_delay_max = SPEED_SWORD