/ai/simple/karma_borg
	name = "Karma Borg"
	desc = "Only hunts those of no karma or the true target."

	radius_find_enemy = 12
	attack_distance = 1

	objective_delay = 5
	attack_delay = 1
	movement_delay = 1

	target_distribution_x = list(0,8,16,32)
	target_distribution_y = list(0,8,16,32)

	sync_attack_delay = TRUE
	sync_movement_delay = TRUE
	simple = TRUE

	var/mob/living/true_target

/ai/simple/on_life()
	. = ..()

	if(.)
		if(!(owner.movement_flags & MOVEMENT_RUNNING) && prob(10))
			owner.movement_flags |= MOVEMENT_RUNNING
		else if(owner.movement_flags & MOVEMENT_RUNNING && prob(5))
			owner.movement_flags &= ~MOVEMENT_RUNNING

/ai/simple/karma_borg/get_attack_score(var/mob/living/L)

	if(L == true_target)
		return 1000

	return ..()

/ai/simple/karma_borg/should_attack_mob(var/mob/living/L)

	if(L == true_target)
		return TRUE

	if(is_player(L))
		var/mob/living/advanced/player/P = L
		if(P.karma > 0)
			return FALSE

	return ..()
