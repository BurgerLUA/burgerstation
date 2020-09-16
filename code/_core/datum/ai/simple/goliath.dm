/ai/goliath

	var/mob/living/simple/npc/goliath/owner_as_goliath

	var/tentacle_attack_ticks = 0
	var/tentacle_ttack_frequency = 100

/ai/goliath/New(var/mob/living/desired_owner)

	owner_as_goliath = desired_owner

	return ..()

/ai/goliath/handle_attacking()

	if(objective_attack)
		if(get_dist(owner,objective_attack) <= attack_distance_max)
			return ..()
		else if(tentacle_attack_ticks < tentacle_ttack_frequency)
			tentacle_attack_ticks++
		else
			owner_as_goliath.tentacle_attack(objective_attack)
			tentacle_attack_ticks = 0

	owner.attack_next = world.time + 40


/ai/goliath/ancient
	tentacle_ttack_frequency = 50

/ai/goliath/broodmother
	tentacle_ttack_frequency = 50