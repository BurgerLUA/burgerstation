/ai/goliath

	radius_find_enemy = 6

	objective_delay = 10
	attack_delay = 1
	movement_delay = 1

	target_distribution_y = list(8,8,8,8,16,32)

	sync_attack_delay = TRUE
	sync_movement_delay = TRUE
	simple = TRUE
	stationary = FALSE

	var/mob/living/simple/npc/goliath/owner_as_goliath

	var/tentacle_attack_ticks = 0

/ai/goliath/New(var/mob/living/desired_owner)

	owner_as_goliath = desired_owner

	return ..()

/ai/goliath/handle_attacking()

	if(objective_attack)
		if(get_dist(owner,objective_attack) <= attack_distance_max)
			return ..()
		else if(tentacle_attack_ticks < 15)
			tentacle_attack_ticks++
		else
			owner_as_goliath.tentacle_attack(objective_attack)
			tentacle_attack_ticks = 0

	attack_ticks = 0