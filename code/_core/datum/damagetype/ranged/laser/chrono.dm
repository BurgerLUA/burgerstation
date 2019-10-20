/damagetype/ranged/laser/chronogun
	name = "chronogun beam"
	id = "chronogun"

	//The base attack damage of the weapon. It's a flat value, unaffected by any skills or attributes.
	attack_damage_base = list(
		MAGIC = DAMAGE_C,
		COLD = DAMAGE_C,
		BIO = DAMAGE_C,
		RAD = DAMAGE_C
	)

	//How much armor to penetrate. It basically removes the percentage of the armor using these values.
	attack_damage_penetration = list(
		MAGIC = ARMOR_B,
		COLD = DAMAGE_D,
		BIO = DAMAGE_D,
		RAD = DAMAGE_D
	)

	crit_multiplier = 1000

/damagetype/ranged/laser/chronogun/get_critical_hit_condition(var/atom/attacker,var/atom/victim,var/atom/weapon,var/atom/hit_object)

	if(lowertext(victim.name) in all_badnames)
		return TRUE

	return FALSE