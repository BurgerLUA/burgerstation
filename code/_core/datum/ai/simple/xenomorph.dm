/ai/simple/xenomorph //Space carp clone
	name = "Xenomorph"
	desc = "AI for xenomorph. They like to hunt in packs."

	radius_find_enemy = VIEW_RANGE

	objective_delay = 10
	attack_delay = 1
	movement_delay = 1

	target_distribution_y = list(4,4,4,16,32,32,32)

	simple = TRUE
	stationary = FALSE
	sync_attack_delay = TRUE
	sync_movement_delay = TRUE

	var/mob/living/simple/npc/xenomorph/pack_leader/leader

/ai/simple/xenomorph/proc/is_valid_leader(var/mob/living/simple/npc/spacecarp/leader/L)
	return !(L.status & FLAG_STATUS_DEAD)

/ai/simple/xenomorph/proc/get_leader()
	for(var/mob/living/simple/npc/xenomorph/pack_leader/L in view(radius_find_enemy,owner))
		if(owner == L)
			continue
		if(is_valid_leader(L))
			return L

	return null

/ai/simple/xenomorph/hostile_message()
	owner.say("HISSSSSSSSSSSS!")

/ai/simple/xenomorph/handle_objectives()

	if(!leader || !is_valid_leader(leader))
		var/mob/living/simple/npc/xenomorph/pack_leader/L = get_leader()
		if(L)
			leader = L

	return ..()

/ai/simple/xenomorph/handle_movement()

	if(!objective_attack && leader)
		if(get_dist(leader,owner) < 2)
			owner.move_dir = get_dir(leader,owner)
		else if(get_dist(leader,owner) > 2)
			owner.move_dir = get_dir(owner,leader)
		else
			owner.move_dir = 0

		movement_ticks = 0

		return TRUE

	return ..()

/ai/simple/xenomorph/pack_leader
	name = "Xenomorph Pack Leader"

	radius_find_enemy = VIEW_RANGE * 2

	objective_delay = 10
	attack_delay = 1
	movement_delay = 1

/ai/simple/xenomorph_queen
	name = "Xenomorph Queen"
	desc = "AI for xenomorph queen."

	radius_find_enemy = VIEW_RANGE * 2

	objective_delay = 6
	attack_delay = 1
	movement_delay = 1

	target_distribution_y = list(4,4,4,16,32,32,32)

