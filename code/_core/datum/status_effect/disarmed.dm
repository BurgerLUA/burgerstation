/status_effect/disarm
	name = "Disarmed"
	desc = "You're disarmed!"
	id = DISARM
	minimum = 0
	maximum = 0
	default_duration = 0

/status_effect/disarm/on_effect_added(var/mob/living/owner,var/atom/source,var/magnitude,var/duration,var/stealthy)

	stealthy = TRUE

	if(is_advanced(owner))
		var/mob/living/advanced/A = owner
		if(A.loc && is_turf(A.loc))
			if(A.drop_hands(A.loc,disarm=TRUE))
				stealthy = FALSE
			for(var/k in A.inventories_by_id)
				var/obj/hud/inventory/I = A.inventories_by_id[k]
				if(I.grabbed_object)
					I.release_object()
					stealthy = FALSE
		if(!stealthy && A.ai)
			A.add_status_effect(PARALYZE,5,5,source = source,stealthy = TRUE) //Prevents the AI from immediately picking the weapon up again and/or reacting.

	return ..()
