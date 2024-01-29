var/global/list/space_cop_tag_shitlist = list()

/ai/advanced/space_cop
	timeout_threshold = 100
	ignore_immortal = TRUE
	reaction_time = 2
	aggression = 1
	assistance = 1
	roaming_distance = VIEW_RANGE
	predict_attack = FALSE

	var/turf/located_chair_turf

	var/event/space_cop/tracked_event

/ai/advanced/space_cop/handle_movement()

	if(located_chair_turf)
		if(located_chair_turf.z != owner.z)
			located_chair_turf = null
			return TRUE
		if(owner.loc != located_chair_turf)
			owner.move_dir = get_dir(owner,located_chair_turf)
		else
			owner.move_dir = 0x0
		last_movement_proc = "chair override"
		return TRUE

	return ..()

/ai/advanced/space_cop/on_damage_received(atom/atom_damaged,atom/attacker,atom/weapon,damagetype/DT,list/damage_table,damage_amount,critical_hit_multiplier,stealthy=FALSE)

	. = ..()

	if(is_living(attacker))
		var/mob/living/L = attacker
		if(L.loyalty_tag && L.loyalty_tag != owner.loyalty_tag && !space_cop_tag_shitlist[L.loyalty_tag])
			space_cop_tag_shitlist[L.loyalty_tag] = TRUE

/ai/advanced/space_cop/is_enemy(atom/A,safety_check=TRUE)
	if(is_living(A))
		var/mob/living/L = A
		if(L.loyalty_tag && space_cop_tag_shitlist[L.loyalty_tag])
			return TRUE
	return ..()