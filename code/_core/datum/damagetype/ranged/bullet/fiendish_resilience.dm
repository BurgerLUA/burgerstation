/damagetype/ranged/bullet/fiendish_resilience

	//The base attack damage of the weapon. It's a flat value, unaffected by any skills or attributes.
	attack_damage_base = list(
		BLUNT = 5,
		PIERCE = 30,
		MAGIC = 10,
		HEAT = 10,
		DARK = 20,
		PAIN = 10
	)

	//How much armor to penetrate. It basically removes the percentage of the armor using these values.
	attack_damage_penetration = list(
		BLUNT = 5,
		PIERCE = 10,
		MAGIC = 10,
		HEAT = 10,
		DARK = 20,
		PAIN = 5
	)

	falloff = VIEW_RANGE*1

/damagetype/ranged/bullet/fiendish_resilience/post_on_hit(var/atom/attacker,var/turf/attacker_turf,var/atom/victim,var/turf/victim_turf,var/atom/weapon,var/atom/hit_object,var/total_damage_dealt=0)

	if(is_living(attacker) && is_living(victim))
		var/mob/living/V = victim
		var/mob/living/A = attacker
		var/reagent_to_add = /reagent/medicine/adrenaline
		var/volume_to_add = 1
		if(!A.dead && V.dead)
			if (V.blood_volume <= 0 || V.blood_volume_max <= 0 || !V.blood_type)
				A.to_chat(span("danger","That enemy has no blood to steal!"))
				return ..()
			var/blood_to_steal = min(V.blood_volume,(A.blood_volume_max - A.blood_volume)) //it took blood, sweat and tears, but...
			if(blood_to_steal > 0)
				V.blood_volume -= blood_to_steal
				A.reagents.add_reagent(reagent_to_add,volume_to_add,activator=attacker) //I successfully stole stolen bloodsteal code!
				play_sound('sound/effects/demon_consume.ogg',attacker_turf,range_max=VIEW_RANGE*0.5)

		return ..()