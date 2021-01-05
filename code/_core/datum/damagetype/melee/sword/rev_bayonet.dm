/damagetype/melee/sword/rev_bayonet
	name = "bayonet"

	attack_damage_base = list(
		PIERCE = DAMAGE_SWORD*0.4*BASE_MELEE_MUL,
		BLADE = DAMAGE_SWORD*0.1*BASE_MELEE_MUL,
	)

	//How much armor to penetrate. It basically removes the percentage of the armor using these values.
	attack_damage_penetration = list(
		PIERCE = AP_SWORD*0.75,
		BLADE = AP_SWORD**0.25,
	)

	attribute_stats = list(
		ATTRIBUTE_STRENGTH = DAMAGE_SWORD*0.1,
		ATTRIBUTE_DEXTERITY = DAMAGE_SWORD*0.2,
	)

	attribute_damage = list(
		ATTRIBUTE_STRENGTH = PIERCE,
		ATTRIBUTE_DEXTERITY = PIERCE
	)

	skill_stats = list(
		SKILL_MELEE = DAMAGE_SWORD*0.2
	)

	skill_damage = list(
		SKILL_MELEE = PIERCE
	)

	attack_delay = SPEED_SWORD*0.5
	attack_delay_max = SPEED_SWORD