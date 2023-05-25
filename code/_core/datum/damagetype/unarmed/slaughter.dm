/damagetype/unarmed/slaughter

	attack_verbs = list("claw")

	hit_effect = /obj/effect/temp/impact/combat/claw

	impact_sounds = list(
		'sound/weapons/unarmed/claw_flesh_01.ogg',
		'sound/weapons/unarmed/claw_flesh_02.ogg',
		'sound/weapons/unarmed/claw_flesh_03.ogg'
	)

	//The base attack damage of the weapon. It's a flat value, unaffected by any skills or attributes.
	attack_damage_base = list(
		BLADE = 30,
		PIERCE = 15
	)

	//How much armor to penetrate. It basically removes the percentage of the armor using these values.
	attack_damage_penetration = list(
		BLADE = 50,
		PIERCE = 50
	)

	attribute_stats = list(
		ATTRIBUTE_STRENGTH = 25,
		ATTRIBUTE_DEXTERITY = 10
	)

	attribute_damage = list(
		ATTRIBUTE_STRENGTH = list(BLADE,PIERCE),
		ATTRIBUTE_DEXTERITY = list(BLADE,PIERCE)
	)

	skill_stats = list(
		SKILL_UNARMED = 50
	)

	skill_damage = list(
		SKILL_UNARMED = list(BLADE,PIERCE),
	)

	throw_mul = 1

	attack_delay = 4
	attack_delay_max = 10

/damagetype/unarmed/slaughter/post_on_hit(var/atom/attacker,var/turf/attacker_turf,var/atom/victim,var/turf/victim_turf,var/atom/weapon,var/atom/hit_object,var/total_damage_dealt=0)

	. = ..()

	if(is_living(attacker) && is_living(victim))
		var/mob/living/V = victim
		var/mob/living/A = attacker
		if(V.dead)
			var/blood_to_steal = min(V.blood_volume,(A.blood_volume_max - A.blood_volume)) //it took blood, sweat and tears, but...
			if(blood_to_steal > 0)
				V.blood_volume -= blood_to_steal
				A.blood_volume = clamp(A.blood_volume+blood_to_steal,0,A.blood_volume_max) //I successfully stole bloodsteal code.
				if(attacker_turf)
					play_sound('sound/effects/demon_consume.ogg',attacker_turf,range_max=VIEW_RANGE*0.5)