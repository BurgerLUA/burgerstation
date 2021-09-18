/damagetype/melee/sword/rev_bayonet
	name = "bayonet"

	attack_damage_base = list(
		BLADE = 10,
		PIERCE = 20
	)

	//How much armor to penetrate. It basically removes the percentage of the armor using these values.
	attack_damage_penetration = list(
		BLADE = 10,
		PIERCE = 25
	)

	attribute_stats = list(
		ATTRIBUTE_STRENGTH = 10,
		ATTRIBUTE_DEXTERITY = 10,
	)

	attribute_damage = list(
		ATTRIBUTE_STRENGTH = list(BLADE,PIERCE),
		ATTRIBUTE_DEXTERITY = list(BLADE,PIERCE)
	)

	skill_stats = list(
		SKILL_MELEE = 20
	)

	skill_damage = list(
		SKILL_MELEE = list(BLADE,PIERCE)
	)

	attack_delay = 6
	attack_delay_max = 8

	crit_multiplier = 4

/damagetype/melee/sword/rev_bayonet/get_crit_chance(var/mob/living/L)
	return 0

/damagetype/melee/sword/rev_bayonet/get_critical_hit_condition(var/atom/attacker,var/atom/victim,var/atom/weapon,var/atom/hit_object)
	return get_true_4dir(attacker.dir) == get_true_4dir(victim.dir)