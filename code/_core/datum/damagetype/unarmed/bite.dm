/damagetype/unarmed/bite/
	attack_verbs = list("bite","chomp","gnaw")

	impact_sounds = list(
		'sound/weapons/unarmed/bite.ogg'
	)

	hit_effect = /obj/effect/temp/impact/combat/bite

	//The base attack damage of the weapon. It's a flat value, unaffected by any skills or attributes.
	attack_damage_base = list(
		BLUNT = 5,
		BLADE = 5,
		PIERCE = 15
	)

	//How much armor to penetrate. It basically removes the percentage of the armor using these values.
	attack_damage_penetration = list(
		BLUNT = 25,
		BLADE = 25,
		PIERCE = 25
	)

	attribute_stats = list(
		ATTRIBUTE_STRENGTH = 75,
	)

	attribute_damage = list(
		ATTRIBUTE_STRENGTH = list(BLUNT,BLADE,PIERCE)
	)

	skill_stats = list(

	)

	skill_damage = list(

	)

	throw_mul = 1

	attack_delay = 10
	attack_delay_max = 20

/damagetype/unarmed/bite/post_on_hit(var/atom/attacker,var/turf/attacker_turf,var/atom/victim,var/turf/victim_turf,var/atom/weapon,var/atom/hit_object,var/total_damage_dealt=0)

	if(is_living(victim) && is_living(attacker) && victim.reagents && total_damage_dealt >= 10 && prob(total_damage_dealt))
		var/mob/living/L = attacker
		if(L.has_status_effect(ZOMBIE))
			victim.reagents.add_reagent(/reagent/toxin/blob_spore,CEILING(total_damage_dealt*0.05,1),activator = attacker)

	. = ..()
