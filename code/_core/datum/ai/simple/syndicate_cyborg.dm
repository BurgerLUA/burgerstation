/ai/syndicate_cyborg
	var/mob/living/simple/silicon/syndieborg/owner_as_borg
	var/next_shoot = 0

/ai/syndicate_cyborg/New(var/mob/living/desired_owner)
	owner_as_borg = desired_owner
	return ..()

/ai/syndicate_cyborg/Destroy()
	owner_as_borg = null
	return ..()



/ai/syndicate_cyborg/handle_attacking()

	if(objective_attack)

		if(next_shoot > world.time || get_dist(owner,objective_attack) <= attack_distance_max)
			return ..()

		owner_as_borg.shoot_gun(objective_attack)
		next_shoot = world.time + 4

		return TRUE

	return ..()