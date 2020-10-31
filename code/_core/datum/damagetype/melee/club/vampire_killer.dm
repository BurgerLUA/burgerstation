/damagetype/melee/club/vampire_killer
	name = "vampire killer"

	attack_damage_base = list(
		BLUNT = DAMAGE_CLUB*0.2,
		HOLY = 0
	)

	attack_damage_penetration = list(
		BLUNT = AP_CLUB*0.25,
		HOLY = AP_CLUB*0.75
	)

	attribute_stats = list(
		ATTRIBUTE_STRENGTH = DAMAGE_CLUB*0.2
	)

	attribute_damage = list(
		ATTRIBUTE_STRENGTH = BLUNT
	)

	skill_stats = list(
		SKILL_MELEE = DAMAGE_CLUB*0.1,
		SKILL_PRAYER = DAMAGE_CLUB*0.5
	)

	skill_damage = list(
		SKILL_MELEE = BLUNT,
		SKILL_PRAYER = HOLY
	)

	attack_delay = SPEED_CLUB*0.5
	attack_delay_max = SPEED_CLUB

/damagetype/melee/club/vampire_killer/post_on_hit(var/atom/attacker,var/atom/victim,var/atom/weapon,var/atom/hit_object,var/atom/blamed,var/total_damage_dealt=0)

	if(is_living(victim))
		var/mob/living/L = victim
		if(L.horizontal)
			L.add_status_effect(DISARM,10,10)
		else
			L.add_status_effect(STUN,10,10)


	return ..()