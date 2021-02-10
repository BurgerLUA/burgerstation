/ai/legion
	var/mob/living/simple/legionare/owner_as_legion

	var/next_legion = 0

/ai/legion/New(var/desired_loc,var/mob/living/desired_owner)
	owner_as_legion = desired_owner
	return ..()

/ai/legion/Destroy()
	owner_as_legion = null
	return ..()

/ai/legion/proc/handle_heads()

	if(objective_attack && world.time >= next_legion)
		owner_as_legion.create_head()
		next_legion = world.time + 10

	return TRUE


/ai/legion/on_life()

	. = ..()

	if(.)
		handle_heads()

	return .