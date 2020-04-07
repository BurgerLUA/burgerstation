/ai/advanced/stand
	use_alerts = FALSE
	ignore_immortal = TRUE
	radius_find_enemy = VIEW_RANGE
	use_cone_vision = FALSE
	retaliate = FALSE

/ai/advanced/stand/on_life()

	if(istype(owner,/mob/living/advanced/stand/))
		var/mob/living/advanced/stand/S = owner
		if(!S.enabled)
			return FALSE

	return ..()


/ai/advanced/stand/handle_movement_roaming()
	return FALSE

/ai/advanced/stand/handle_movement_crowding()
	return FALSE

/ai/advanced/stand/should_attack_mob(var/mob/living/L)
	if(L.stand && L.stand.linked_stand == owner)
		return FALSE
	return ..()

/ai/advanced/stand/set_objective(var/mob/living/L)
	. = ..()
	owner.set_dir(owner.dir,TRUE)
	return .

/ai/advanced/stand/should_attack_mob(var/mob/living/L)

	if(L == owner)
		return FALSE

	if(!can_attack(L))
		return FALSE

	if(istype(L,/mob/living/advanced/stand/))
		return TRUE

	if(istype(owner,/mob/living/advanced/stand/))
		var/mob/living/advanced/stand/S = owner
		if(L.ai && L.ai.should_attack_mob(S.owner))
			return TRUE

	return FALSE


/ai/advanced/stand/get_attack_score(var/mob/living/L)
	. = ..()
	if(istype(L,/mob/living/advanced/stand/))
		. += 10
	return .