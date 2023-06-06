/mob/living/advanced/npc/beefman
	name = "beefman"
	desc = "I told you not to go alone."
	desc_extended = "A disgusting monster made entirely out of beef. It's unknown where these things came from, but we do know that they're attracted by the rotting corpses of humanoids."
	ai = /ai/advanced/beef
	species = "beefman"

	dna = /dna/beef

	iff_tag = "Beefman"
	loyalty_tag = "Beefman"

	movement_delay = 2 //2nd Lowest possible.

	health_base = 50

	butcher_contents = list(
		/obj/item/container/edible/dynamic/meat/raw_beefman,
		/obj/item/container/edible/dynamic/meat/raw_beefman,
		/obj/item/container/edible/dynamic/meat/raw_beefman,
		/obj/item/container/edible/dynamic/meat/raw_beefman,
		/obj/item/soulgem/rare
	)

	death_threshold = 0

	level = 14

/mob/living/advanced/npc/beefman/on_damage_received(var/atom/atom_damaged,var/atom/attacker,var/atom/weapon,var/damagetype/DT,var/list/damage_table,var/damage_amount,var/critical_hit_multiplier,var/stealthy=FALSE)

	if(damage_amount > 20 & luck(src,20 + damage_amount,FALSE))
		play_sound('sound/weapons/unarmed/beef/beef_grab.ogg',get_turf(atom_damaged),range_max=VIEW_RANGE)
		add_status_effect(STAGGER,5,5,source = attacker)

	. = ..()

/mob/living/advanced/npc/beefman/proc/beef()
	if(!health)
		return FALSE
	var/brute_to_remove = health.damage[BRUTE]*0.5
	var/burn_to_remove = health.damage[BURN]*0.5
	if(health.health_current + brute_to_remove + burn_to_remove <= 0)
		return FALSE
	health.adjust_loss_smart(brute=-brute_to_remove,burn=-burn_to_remove)
	if(!check_death())
		revive()
	return TRUE

/mob/living/advanced/npc/beefman/post_death()
	CALLBACK("beef_revive_\ref[src]",SECONDS_TO_DECISECONDS(rand(3,8)),src,src::beef())
	return ..()

/mob/living/advanced/npc/beefman/get_plane()
	if(horizontal)
		return PLANE_MOVABLE_DEAD
	return PLANE_MOVABLE_STEALTH //Always stealth.

/mob/living/advanced/npc/beefman/post_move(var/atom/old_loc)
	. = ..()
	if(is_simulated(old_loc))
		var/turf/simulated/S = old_loc
		if(S.blood_level_hard > 0)
			var/heal_amount = 0
			for(var/obj/effect/cleanable/blood/B in S.contents)
				heal_amount += max(1,B.blood_level)
				qdel(B)
			if(heal_amount > 0)
				CREATE(/obj/effect/temp/healing,S)
