/ai/legion_head
	var/mob/living/simple/legionare_head/owner_as_legion_head
	use_alerts = FALSE

/ai/legion_head/New(var/mob/living/desired_owner)
	owner_as_legion_head = desired_owner
	return ..()

/ai/legion_head/should_attack_mob(var/mob/living/L) //Only thing different is that it targets handcuffed and dead targets.

	if(L == owner)
		return FALSE

	if(L.qdeleting)
		return FALSE

	if(L.immortal && !ignore_immortal)
		return FALSE

	if(timeout_threshold && L.client && L.client.inactivity >= DECISECONDS_TO_TICKS(timeout_threshold))
		return FALSE

	if(!is_enemy(L,FALSE))
		return FALSE

	if(!L.can_be_attacked(owner))
		return FALSE

	return TRUE


/ai/legion_head/Destroy()
	owner_as_legion_head = null
	return ..()