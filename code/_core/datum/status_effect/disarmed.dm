/status_effect/disarm
	name = "Disarmed"
	desc = "You're disarmed!"
	id = DISARM
	minimum = 0
	maximum = 0
	default_duration = 0

/status_effect/disarm/on_effect_added(var/mob/living/owner,var/atom/source,var/magnitude,var/duration,var/stealthy)

	if(is_advanced(owner))
		var/mob/living/advanced/A = owner
		A.drop_hands(A.loc)
		for(var/k in A.inventories_by_id)
			var/obj/hud/inventory/I = A.inventories_by_id[k]
			if(I.grabbed_object)
				I.release_object()
	else
		stealthy = TRUE

	return ..()
