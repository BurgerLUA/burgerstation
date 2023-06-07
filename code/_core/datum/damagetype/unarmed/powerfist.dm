/damagetype/unarmed/powerfist
	attack_verbs = list("punch","hit","strike","pummel","pound")

	hit_effect = /obj/effect/temp/impact/combat/punch

	//The base attack damage of the weapon. It's a flat value, unaffected by any skills or attributes.
	attack_damage_base = list(
		BLUNT = 40
	)

	//How much armor to penetrate. It basically removes the percentage of the armor using these values.
	attack_damage_penetration = list(
		BLUNT = 0
	)

	attribute_stats = list(
		ATTRIBUTE_STRENGTH = 25,
		ATTRIBUTE_DEXTERITY = 10
	)

	attribute_damage = list(
		ATTRIBUTE_STRENGTH = BLUNT,
		ATTRIBUTE_DEXTERITY = BLUNT
	)

	skill_stats = list(
		SKILL_UNARMED = 30
	)

	skill_damage = list(
		SKILL_UNARMED = BLUNT
	)

	cqc_tag = "4"

	attack_delay = 10
	attack_delay_max = 15

/damagetype/unarmed/powerfist/can_man

	attack_damage_base = list(
		BLUNT = 80
	)

	attack_delay = 10
	attack_delay_max = 15

	crit_multiplier = 4
	crit_chance = 0
	crit_chance_max = 0

/damagetype/unarmed/powerfist/can_man/get_crit_chance(var/mob/living/L)
	return 0

/damagetype/unarmed/powerfist/can_man/get_critical_hit_condition(var/atom/attacker,var/atom/victim,var/atom/weapon,var/atom/hit_object)

	if(!ismovable(victim))
		return TRUE

	var/atom/movable/M = victim

	return M.anchored