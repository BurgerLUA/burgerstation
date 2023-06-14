/damagetype/ranged/magic/blackflame/
	attack_damage_base = list(
		HEAT = 30,
		ARCANE = 10,
		DARK = 10
	)

	attribute_stats = list(
		ATTRIBUTE_INTELLIGENCE = 20,
		ATTRIBUTE_VITALITY = 30
	)

	attribute_damage = list(
		ATTRIBUTE_INTELLIGENCE = list(ARCANE,HEAT),
		ATTRIBUTE_VITALITY = DARK
	)

	skill_stats = list(
		SKILL_MAGIC = 20,
		SKILL_PRAYER = 30,
	)

	skill_damage = list(
		SKILL_MAGIC = list(HEAT,ARCANE),
		SKILL_PRAYER = DARK
	)

/damagetype/ranged/magic/blackflame/post_on_hit(var/atom/attacker,var/turf/attacker_turf,var/atom/victim,var/turf/victim_turf,var/atom/weapon,var/atom/hit_object,var/total_damage_dealt=0)

	if(is_living(victim))
		var/mob/living/L = victim
		if(L.on_fire)
			var/loyalty_tag_to_use
			if(is_living(attacker))
				var/mob/living/L2 = attacker
				loyalty_tag_to_use = L2.loyalty_tag
			explode(victim_turf,2,attacker,weapon,loyalty_tag_to_use)
			L.extinguish()
		else
			L.ignite(50,source=attacker)

	. = ..()