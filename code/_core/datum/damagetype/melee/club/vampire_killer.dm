/damagetype/melee/club/vampire_killer
	name = "vampire killer"

	attack_damage_base = list(
		BLUNT = 60*0.2,
		HOLY = 0
	)

	attack_damage_penetration = list(
		BLUNT = 60*0.25,
		HOLY = 60*0.75
	)

	attribute_stats = list(
		ATTRIBUTE_STRENGTH = 60*0.2
	)

	attribute_damage = list(
		ATTRIBUTE_STRENGTH = BLUNT
	)

	skill_stats = list(
		SKILL_MELEE = 60*0.1,
		SKILL_PRAYER = 60*0.5
	)

	skill_damage = list(
		SKILL_MELEE = BLUNT,
		SKILL_PRAYER = HOLY
	)

	bonus_experience_skill = list(
		SKILL_MELEE = 25, //25%
		SKILL_PRAYER = 25
	)

	attack_delay = 14*0.5
	attack_delay_max = 14

/damagetype/melee/club/vampire_killer/post_on_hit(var/atom/attacker,var/atom/victim,var/atom/weapon,var/atom/hit_object,var/atom/blamed,var/total_damage_dealt=0)

	if(is_living(victim) && prob(total_damage_dealt))
		var/mob/living/L = victim
		L.add_status_effect(DISARM,10,10)

	return ..()