/damagetype/ranged/magic/blackflame/
	name = "blackflame"

	//The base attack damage of the weapon. It's a flat value, unaffected by any skills or attributes.
	attack_damage_base = list(
		HEAT = 60*0.2,
		ARCANE = 60*0.1,
		DARK = 60*0.1
	)

	attribute_stats = list(
		ATTRIBUTE_INTELLIGENCE = 60*0.2
	)

	attribute_damage = list(
		ATTRIBUTE_INTELLIGENCE = DARK
	)

	skill_stats = list(
		SKILL_SORCERY = 60*0.5,
	)

	skill_damage = list(
		SKILL_SORCERY = list(HEAT,DARK)
	)

	bonus_experience_skill = list(
		SKILL_SORCERY = 75 //75%
	)

/damagetype/ranged/magic/blackflame/post_on_hit(var/atom/attacker,var/atom/victim,var/atom/weapon,var/atom/hit_object,var/atom/blamed,var/total_damage_dealt=0)
	if(is_living(victim))
		var/mob/living/L = victim
		L.add_status_effect(FIRE,100,100,stealthy=L.on_fire)
	return ..()