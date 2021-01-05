/damagetype/melee/club/goedendag
	name = "goedendag"

	//The base attack damage of the weapon. It's a flat value, unaffected by any skills or attributes.
	attack_damage_base = list(
		BLUNT = DAMAGE_GREATCLUB*0.15*BASE_MELEE_MUL,
		PIERCE = DAMAGE_GREATCLUB*0.1*BASE_MELEE_MUL
	)

	//How much armor to penetrate. It basically removes the percentage of the armor using these values.
	attack_damage_penetration = list(
		BLUNT = AP_GREATCLUB*0.75,
		PIERCE = AP_GREATCLUB*0.25
	)

	attribute_stats = list(
		ATTRIBUTE_STRENGTH = DAMAGE_GREATCLUB*0.5
	)

	attribute_damage = list(
		ATTRIBUTE_STRENGTH = BLUNT,
		ATTRIBUTE_STRENGTH = PIERCE
	)

	skill_stats = list(
		SKILL_MELEE = DAMAGE_GREATCLUB*0.25
	)

	skill_damage = list(
		SKILL_MELEE = BLUNT
	)

	attack_delay = SPEED_GREATCLUB*0.5
	attack_delay_max = SPEED_GREATCLUB