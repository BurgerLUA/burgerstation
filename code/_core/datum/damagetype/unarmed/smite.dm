/damagetype/unarmed/smite

	attack_verbs = list("smite")

	hit_effect = /obj/effect/temp/impact/combat/claw

	impact_sounds = list(
		'sound/weapons/magic/disintegrate.ogg',
	)

	//The base attack damage of the weapon. It's a flat value, unaffected by any skills or attributes.
	attack_damage_base = list(

	)

	//How much armor to penetrate. It basically removes the percentage of the armor using these values.
	attack_damage_penetration = list(

	)

	attribute_stats = list(

	)

	attribute_damage = list(

	)

	skill_stats = list(

	)

	skill_damage = list(

	)

	bonus_experience_skill = list(
		SKILL_MAGIC = 50 //100%
	)

	cqc_tag = "4"

	attack_delay = 10
	attack_delay_max = 10

	sneak_attack_multiplier = 1
	allow_power_attacks = FALSE
	crit_multiplier = 1

/damagetype/unarmed/smite/get_attack_damage(var/atom/attacker,var/atom/victim,var/atom/weapon,var/atom/hit_object,var/damage_multiplier=1)

	. = list()

	if(is_advanced(victim) && victim.health && victim.health.health_current > 0)
		.[DARK] = victim.health.health_current * 0.25 * damage_multiplier
	else
		.[DARK] = 1


/damagetype/unarmed/smite/post_on_hit(var/atom/attacker,var/turf/attacker_turf,var/atom/victim,var/turf/victim_turf,var/atom/weapon,var/atom/hit_object,var/total_damage_dealt=0)

	. = ..()

	if(is_item(weapon))
		var/obj/item/I = weapon
		qdel(I)