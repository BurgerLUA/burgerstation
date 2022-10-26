/damagetype/ranged/magic/inferno
	attack_damage_base = list(
		HEAT = 45*0.55,
	)

	attribute_stats = list(
		ATTRIBUTE_INTELLIGENCE = 45*0.2
	)

	attribute_damage = list(
		ATTRIBUTE_INTELLIGENCE = list(HEAT)
	)

	skill_stats = list(
		SKILL_MAGIC_OFFENSIVE = 45*0.3,
	)

	skill_damage = list(
		SKILL_MAGIC_OFFENSIVE = HEAT
	)

	bonus_experience_skill = list(
		SKILL_MAGIC_OFFENSIVE = 75 //75%
	)

/damagetype/ranged/magic/inferno/post_on_hit(var/atom/attacker,var/atom/victim,var/atom/weapon,var/atom/hit_object,var/atom/blamed,var/total_damage_dealt=0)
	if(is_living(victim))
		var/mob/living/L = victim
		L.add_status_effect(FIRE,100,100,stealthy=L.on_fire)
	return ..()