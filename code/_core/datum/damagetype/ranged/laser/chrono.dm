/damagetype/ranged/laser/chronogun
	name = "chronogun beam"
	id = "chronogun"

	//The base attack damage of the weapon. It's a flat value, unaffected by any skills or attributes.
	attack_damage_base = list(
		MAGIC = DAMAGE_D,
		COLD = DAMAGE_C,
		BIO = DAMAGE_D,
		RAD = DAMAGE_D
	)

	//How much armor to penetrate. It basically removes the percentage of the armor using these values.
	attack_damage_penetration = list(
		MAGIC = ARMOR_E,
		COLD = DAMAGE_E,
		BIO = DAMAGE_E,
		RAD = DAMAGE_E
	)

	crit_multiplier = 10

/damagetype/ranged/laser/chronogun/get_critical_hit_condition(var/atom/attacker,var/atom/victim,var/atom/weapon,var/atom/hit_object)

	if(SSbadnames.all_badnames[lowertext(victim.name)])
		return TRUE

	return FALSE