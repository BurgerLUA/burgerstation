/damagetype/ranged/magic/inferno
	attack_damage_base = list(
		HEAT = 60,
	)

	attribute_stats = list(
		ATTRIBUTE_INTELLIGENCE = 20
	)

	attribute_damage = list(
		ATTRIBUTE_INTELLIGENCE = list(HEAT)
	)

	skill_stats = list(
		SKILL_MAGIC = 20,
	)

	skill_damage = list(
		SKILL_MAGIC = HEAT
	)

	force_attacker_armor_calculations_with = ARCANE

/damagetype/ranged/magic/inferno/post_on_hit(atom/attacker,turf/attacker_turf,atom/victim,turf/victim_turf,atom/weapon,atom/hit_object,total_damage_dealt=0)

	if(is_living(victim))
		var/mob/living/L = victim
		L.add_status_effect(FIRE,100,100,stealthy=L.on_fire)

	. = ..()