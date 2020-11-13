/ai/advanced/stand
	use_alerts = FALSE
	ignore_immortal = TRUE
	use_cone_vision = FALSE
	retaliate = FALSE
	should_find_weapon = FALSE

/ai/advanced/stand/on_life()
	if(istype(owner,/mob/living/advanced/stand/))
		var/mob/living/advanced/stand/S = owner
		if(!S.enabled)
			return FALSE
	return ..()


/ai/advanced/stand/handle_movement_roaming()
	return FALSE

/ai/advanced/stand/set_objective(var/mob/living/L)
	. = ..()
	owner.set_dir(owner.dir,TRUE)
	return .

/ai/advanced/stand/is_enemy(var/atom/A,var/safety_check=TRUE)
	if(is_living(A))
		var/mob/living/L = A
		if(L.stand && L.stand.linked_stand == owner)
			return FALSE
	return ..()

/ai/advanced/stand/should_attack_mob(var/mob/living/L)

	if(L.dead)
		return FALSE

	if(is_enemy(L,FALSE))
		return FALSE

	if(L.immortal && !ignore_immortal)
		return FALSE

	if(timeout_threshold && L.client && L.client.inactivity >= DECISECONDS_TO_TICKS(timeout_threshold))
		return FALSE

	if(!L.can_be_attacked(owner))
		return FALSE

	return TRUE


/ai/advanced/stand/is_enemy(var/atom/A,var/safety_check=TRUE)
	if(A == owner)
		return FALSE
	if(!safety_check)
		var/mob/living/advanced/stand/S = owner
		if(A == S.owner)
			return FALSE
		if(is_living(A))
			var/mob/living/L = A
			if(L.ai && L.ai.is_enemy(S.owner))
				return TRUE
	return FALSE

/ai/advanced/stand/get_attack_score(var/mob/living/L)
	. = ..()
	if(istype(L,/mob/living/advanced/stand/))
		. += 10
	return .