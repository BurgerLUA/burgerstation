/damagetype/ranged/magic/holy_cross
	attack_damage_base = list(
		BLUNT = 30,
		HOLY = 0
	)

	attribute_stats = list()

	attribute_damage = list()

	skill_stats = list(
		SKILL_PRAYER = 120,
	)

	skill_damage = list(
		SKILL_PRAYER = list(BLUNT,HOLY)
	)

	force_attacker_armor_calculations_with = HOLY

	crit_multiplier = 2

/damagetype/ranged/magic/holy_cross/get_critical_hit_condition(var/atom/attacker,var/atom/victim,var/atom/weapon,var/atom/hit_object)

	if(is_living(victim))
		var/mob/living/L = victim
		return L.boss

	. = ..()