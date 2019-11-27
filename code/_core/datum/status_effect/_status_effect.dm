/datum/status/
	name = "status effect"
	id = null

	var/mob/living/owner

/datum/status/New(var/mob/living/desired_owner)
	owner = desired_owner
	return ..()



/datum/status/destroy()