/ai/goliath

	var/mob/living/simple/goliath/owner_as_goliath

	attack_distance_max = 1

	var/next_tentacle_attack = 100
	var/tentacle_distance_max = 4

/ai/goliath/New(var/desired_loc,var/mob/living/desired_owner)
	owner_as_goliath = desired_owner
	return ..()

/ai/goliath/Destroy()
	owner_as_goliath = null
	return ..()

/ai/goliath/handle_attacking()

	if(objective_attack && alert_level == ALERT_LEVEL_COMBAT && next_tentacle_attack <= world.time)
		var/target_distance = get_dist(owner,objective_attack)
		if(target_distance > attack_distance_max && target_distance <= tentacle_distance_max)
			owner_as_goliath.do_tentacle_attack(objective_attack)
			next_tentacle_attack = world.time + initial(next_tentacle_attack)
			owner.attack_next = world.time + 40


/ai/goliath/ancient
	next_tentacle_attack = 40
	tentacle_distance_max = 5

/ai/goliath/broodmother
	next_tentacle_attack = 40
	tentacle_distance_max = 6