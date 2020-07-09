/damagetype/ranged/magic/fireball/ash_drake
	name = "fireball"

	//The base attack damage of the weapon. It's a flat value, unaffected by any skills or attributes.
	attack_damage_base = list(
		HEAT = 20,
		MAGIC = 20
	)

	attribute_stats = list(
		ATTRIBUTE_INTELLIGENCE = 40
	)

	attribute_damage = list(
		ATTRIBUTE_INTELLIGENCE = list(MAGIC,HEAT)
	)

	skill_stats = list(
		SKILL_SORCERY = 40,
	)

	skill_damage = list(
		SKILL_SORCERY = list(MAGIC,HEAT)
	)

/damagetype/ranged/magic/fireball/ash_drake/post_on_hit(var/atom/attacker,var/atom/victim,var/atom/weapon,var/atom/hit_object,var/atom/blamed,var/total_damage_dealt=0)
	if(is_living(victim))
		var/mob/living/L = victim
		L.add_status_effect(FIRE,100,0,stealthy=L.on_fire)
	return ..()