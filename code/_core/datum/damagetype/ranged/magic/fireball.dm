/damagetype/ranged/magic/fireball
	attack_damage_base = list(
		HEAT = 60*0.3,
		ARCANE = 60*0.2
	)

	attribute_stats = list(
		ATTRIBUTE_INTELLIGENCE = 60*0.2
	)

	attribute_damage = list(
		ATTRIBUTE_INTELLIGENCE = ARCANE
	)

	skill_stats = list(
		SKILL_MAGIC_OFFENSIVE = 60*0.3,
	)

	skill_damage = list(
		SKILL_MAGIC_OFFENSIVE = ARCANE
	)

	bonus_experience_skill = list(
		SKILL_MAGIC_OFFENSIVE = 75 //75%
	)

/damagetype/ranged/magic/fireball/post_on_hit(var/atom/attacker,var/atom/victim,var/atom/weapon,var/atom/hit_object,var/atom/blamed,var/total_damage_dealt=0)
	if(is_living(victim))
		var/mob/living/L = victim
		L.add_status_effect(FIRE,50,0,stealthy=L.on_fire)
	return ..()