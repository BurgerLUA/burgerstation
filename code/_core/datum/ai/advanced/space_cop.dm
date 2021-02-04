var/global/list/space_cop_tag_shitlist = list()

/ai/advanced/space_cop
	target_distribution_x = list(16)
	target_distribution_y = list(16)
	roaming_distance = VIEW_RANGE*4
	timeout_threshold = 100
	ignore_immortal = TRUE
	reaction_time = 2
	aggression = 1
	assistance = 1
	roam = TRUE
	roam_counter = 30
	predict_attack = FALSE

	var/turf/located_chair_turf

	var/event/space_cop/tracked_event

/ai/advanced/space_cop/handle_objectives(var/tick_rate)

	if(!roam && !located_chair_turf && !length(current_path))
		if(tracked_event && tracked_event.recalling && tracked_event.associated_shuttle_controller && get_dist(owner,tracked_event.associated_shuttle_controller) <= VIEW_RANGE)
			for(var/obj/structure/interactive/chair/C in view(owner.loc,8))
				var/area/A1 = get_area(C)
				var/area/A2 = get_area(tracked_event.associated_shuttle_controller)
				if(A1 == A2)
					located_chair_turf = get_turf(C)
					break

	return ..()

/ai/advanced/space_cop/handle_movement()

	if(located_chair_turf)
		if(located_chair_turf.z != owner.z)
			located_chair_turf = null
			return TRUE
		if(owner.loc != located_chair_turf)
			if(handle_movement_sidestep())
				return TRUE
			owner.move_dir = get_dir(owner,located_chair_turf)
		else
			owner.move_dir = 0x0
		return TRUE

	return ..()

/ai/advanced/space_cop/on_damage_received(var/atom/atom_damaged,var/atom/attacker,var/atom/weapon,var/list/damage_table,var/damage_amount,var/critical_hit_multiplier,var/stealthy=FALSE)

	. = ..()

	if(is_living(attacker))
		var/mob/living/L = attacker
		if(L.loyalty_tag && L.loyalty_tag != owner.loyalty_tag && !space_cop_tag_shitlist[L.loyalty_tag])
			space_cop_tag_shitlist[L.loyalty_tag] = TRUE

	return .


/ai/advanced/space_cop/is_enemy(var/atom/A,var/safety_check=TRUE)
	if(is_living(A))
		var/mob/living/L = A
		if(L.loyalty_tag && space_cop_tag_shitlist[L.loyalty_tag])
			return TRUE
	return ..()