/ai/simple/carp
	name = "Carp"
	desc = "AI for carp. They like to hunt in packs."

	radius_find_enemy = 12

	objective_delay = 10
	attack_delay = 1
	movement_delay = 1

	target_distribution = list(4,4,4,16,32,32,32)

	sync_attack_delay = TRUE
	sync_movement_delay = TRUE
	simple = TRUE
	stationary = FALSE

	var/mob/living/simple/npc/spacecarp/leader/carp_leader


/ai/simple/carp/proc/is_valid_leader(var/mob/living/simple/npc/spacecarp/leader/L)
	return !(L.status & FLAG_STATUS_DEAD)

/ai/simple/carp/proc/get_leader()
	for(var/mob/living/simple/npc/spacecarp/leader/L in view(radius_find_enemy,owner))
		if(owner == L)
			continue
		if(is_valid_leader(L))
			return L

	return null

/ai/simple/carp/handle_objectives()

	if(!carp_leader || !is_valid_leader(carp_leader))
		var/mob/living/simple/npc/spacecarp/leader/new_leader = get_leader()
		if(new_leader)
			carp_leader = new_leader

	return ..()

/ai/simple/carp/handle_movement()

	if(!objective_attack && carp_leader)
		if(get_dist(carp_leader,owner) < 2)
			owner.move_dir = get_dir(carp_leader,owner)
		else if(get_dist(carp_leader,owner) > 2)
			owner.move_dir = get_dir(owner,carp_leader)
		else
			owner.move_dir = 0

		return TRUE

	return ..()
