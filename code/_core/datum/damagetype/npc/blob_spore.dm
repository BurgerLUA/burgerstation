/damagetype/npc/blob_spore

	//The base attack damage of the weapon. It's a flat value, unaffected by any skills or attributes.
	attack_damage_base = list(
		BLADE = 20*0.2,
		PIERCE = 20*0.3,
		BIO = 20*0.3
	)

	//How much armor to penetrate. It basically removes the percentage of the armor using these values.
	attack_damage_penetration = list(
		BLUNT = 100*0.2,
		PIERCE = 100*0.3,
		BIO = 100*0.5
	)

	attribute_stats = list(
		ATTRIBUTE_STRENGTH = 20*0.2
	)

	attribute_damage = list(
		ATTRIBUTE_STRENGTH = PIERCE
	)

	attack_delay = 14*0.5
	attack_delay_max = 14

/damagetype/npc/blob_spore/post_on_hit(atom/attacker,turf/attacker_turf,atom/victim,turf/victim_turf,atom/weapon,atom/hit_object,total_damage_dealt=0)
	. = ..()
	if(victim_turf && is_advanced(victim) && is_organ(hit_object) && istype(attacker,/mob/living/simple/blob_spore))
		var/obj/item/organ/O = hit_object
		var/mob/living/advanced/A = victim
		if(O.id == BODY_HEAD && O.health.health_current <= O.health.health_max*0.5)
			var/obj/item/clothing/head/helmet/full/blob_spore/H = new(victim_turf)
			INITIALIZE(H)
			GENERATE(H)
			FINALIZE(H)
			if(H.quick_equip(A,silent=TRUE))
				qdel(attacker)
			else
				qdel(H)