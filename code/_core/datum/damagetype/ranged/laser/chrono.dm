/damagetype/ranged/laser/chronogun
	name = "chronogun beam"

	//The base attack damage of the weapon. It's a flat value, unaffected by any skills or attributes.
	attack_damage_base = list(
		ARCANE = 10,
		COLD = 20,
		BIO = 10,
		RAD = 30
	)

	//How much armor to penetrate. It basically removes the percentage of the armor using these values.
	attack_damage_penetration = list(
		ARCANE = 10,
		COLD = 10,
		BIO = 10,
		RAD = 10
	)

	crit_multiplier = 10

/damagetype/ranged/laser/chronogun/get_critical_hit_condition(var/atom/attacker,var/atom/victim,var/atom/weapon,var/atom/hit_object)

	if(SSbadnames.all_badnames[lowertext(victim.name)])
		return TRUE

	return FALSE