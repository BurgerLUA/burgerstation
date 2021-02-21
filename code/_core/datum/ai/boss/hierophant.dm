/ai/boss/hierophant/

	var/mob/living/simple/hierophant/owner_as_hierophant

	var/next_big_attack = 0


/ai/boss/hierophant/New(var/desired_loc,var/mob/living/desired_owner)
	owner_as_hierophant = desired_owner
	return ..()

/ai/boss/hierophant/Destroy()
	owner_as_hierophant = null
	return ..()

/ai/boss/hierophant/handle_objectives()

	. = ..()

	if(objective_attack && world.time >= next_big_attack)
		var/next_time = 1 + max(0,owner_as_hierophant.health.health_current/owner_as_hierophant.health.health_max)*3
		next_big_attack = world.time + SECONDS_TO_DECISECONDS(next_time)
		switch(rand(1,2))
			if(1)
				owner_as_hierophant.chain_blast_random()
			if(2)
				owner_as_hierophant.chain_blast_targets()
