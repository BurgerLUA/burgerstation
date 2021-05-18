/ai/goliath

	var/mob/living/simple/goliath/owner_as_goliath



	attack_distance_max = 1

	var/next_tentacle_attack = 100

/ai/goliath/New(var/desired_loc,var/mob/living/desired_owner)
	owner_as_goliath = desired_owner
	return ..()

/ai/goliath/Destroy()
	owner_as_goliath = null
	return ..()

/ai/goliath/handle_attacking()

	if(objective_attack && alert_level == ALERT_LEVEL_COMBAT)

		var/target_distance = get_dist(owner,objective_attack)

		if(target_distance <= attack_distance_max)
			return ..()

		if(target_distance <= VIEW_RANGE && next_tentacle_attack <= world.time)
			owner_as_goliath.do_tentacle_attack(objective_attack)
			next_tentacle_attack = world.time + initial(next_tentacle_attack)
			owner.attack_next = world.time + 40


/ai/goliath/ancient
	next_tentacle_attack = 40

/ai/goliath/broodmother
	next_tentacle_attack = 40