/damagetype/ranged/bullet/fiendish_resilience
	name = "revolver bullet"

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

/damagetype/ranged/bullet/fiendish_resilience/post_on_hit(var/atom/attacker,var/atom/victim,var/atom/weapon,var/atom/hit_object,var/atom/blamed,var/total_damage_dealt=0)
	if(is_living(attacker) && is_living(victim))
		var/mob/living/V = victim
		var/mob/living/A = attacker
		var/reagent_to_add = /reagent/medicine/adrenaline
		var/volume_to_add = 1
		if(!A.dead && V.dead)
			var/blood_to_steal = min(V.blood_volume,(A.blood_volume_max - A.blood_volume)) //it took blood, sweat and tears, but...
			if(blood_to_steal > 0)
				V.blood_volume -= blood_to_steal
				A.reagents.add_reagent(reagent_to_add,volume_to_add,caller=attacker) //I successfully stole stolen bloodsteal code!
				A.health.adjust_loss_smart(oxy = -blood_to_steal)
				play_sound(pick('sound/effects/demon_consume.ogg'),get_turf(V),range_max=VIEW_RANGE*0.5)
			else if (V.blood_volume <= 0)
				A.to_chat(span("danger","That enemy has no vigor to steal!"))

		return ..()