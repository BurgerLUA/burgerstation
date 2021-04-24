/damagetype/melee/club/vampire_killer
	name = "vampire killer"

	attack_damage_base = list(
		BLUNT = 10,
		BLADE = 10,
		HOLY = 0
	)

	attack_damage_penetration = list(
		BLUNT = 25,
		BLADE = 25,
		HOLY = 0
	)

	attribute_stats = list(
		ATTRIBUTE_STRENGTH = 20,
		ATTRIBUTE_DEXTERITY = 10
	)

	attribute_damage = list(
		ATTRIBUTE_STRENGTH = BLUNT
	)

	skill_stats = list(
		SKILL_MELEE = 20,
		SKILL_PRAYER = 20
	)

	skill_damage = list(
		SKILL_MELEE = BLUNT,
		SKILL_PRAYER = HOLY
	)

	bonus_experience_skill = list(
		SKILL_MELEE = 25, //25%
		SKILL_PRAYER = 25
	)

	attack_delay = 15
	attack_delay_max = 20

/damagetype/melee/club/vampire_killer/post_on_hit(var/atom/attacker,var/atom/victim,var/atom/weapon,var/atom/hit_object,var/atom/blamed,var/total_damage_dealt=0)

	if(is_living(victim) && prob(total_damage_dealt))
		var/mob/living/L = victim
		L.add_status_effect(DISARM,10,10)

	return ..()