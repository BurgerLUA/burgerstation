/damagetype/melee/club/goedendag
	name = "goedendag"

	//The base attack damage of the weapon. It's a flat value, unaffected by any skills or attributes.
	attack_damage_base = list(
		BLUNT = 105*0.15,
		PIERCE = 105*0.1
	)

	//How much armor to penetrate. It basically removes the percentage of the armor using these values.
	attack_damage_penetration = list(
		BLUNT = 120*0.75,
		PIERCE = 120*0.25
	)

	attribute_stats = list(
		ATTRIBUTE_STRENGTH = 105*0.5
	)

	attribute_damage = list(
		ATTRIBUTE_STRENGTH = list(BLUNT,PIERCE)
	)

	skill_stats = list(
		SKILL_MELEE = 105*0.25
	)

	skill_damage = list(
		SKILL_MELEE = BLUNT
	)

	attack_delay = 20*0.5
	attack_delay_max = 20